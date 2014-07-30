class Post < ActiveRecord::Base
  include PGArrayMethods
  include RedArrayMethods
  self.synchronous_commit(false)
  attr_readonly :user_id, except: {on: :create}

  mount_uploader :photo, PhotoUploader

  validates :user_id, presence: true, length: {maximum: 5000}
  validates :shareable_type, inclusion: {in: %w( Post )}, allow_nil: true
  validates :youtube_url, length: {maximum: 500}
  validate  :presence_of_content, :valid_content_combination
  after_destroy :remove_from_list
  
##### Relations

  belongs_to :shareable, polymorphic: true

  def user
    User.find(self.user_id)
  end

  def likers
    User.find(self.liker_ids)
  end

  def comments
    Comment.find(self.comment_ids)
  end

  def tagged_users
    User.find(self.tagged_user_ids)
  end

###

  def likers_count
    self.redcount(:liker_ids)
  end

  def comments_count
    self.redcount(:comment_ids)
  end
  
  def share_count
    self.redcount(:shared_by_ids)
  end

  def flag_count
    self.flagger_ids.count
  end

##### Redis Attributes

  def liker_ids
    self.redget(:liker_ids)
  end

  def comment_ids
    self.redget(:comment_ids)
  end

private

  def valid_content_combination
    return unless (photo.present? && shareable_type.present?)       ||
                  (photo.present? && youtube_url.present?)          ||
                  (shareable_type.present? && youtube_url.present?)
    errors.add(:base, "Don't post a photo and share content!")
  end

  def presence_of_content
    return unless  body.blank?            &&  
                   photo.blank?           &&  
                   shareable_type.blank?  &&  
                   youtube_url.blank?

    errors.add(:base, "Try posting something!")
  end


  def remove_from_list
    self.user.remove(:owned_post_ids, self.id)
  end
end

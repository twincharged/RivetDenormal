class Post < ActiveRecord::Base
  include PGArrayMethods
  include RedArrayMethods
  self.synchronous_commit(false)

  mount_uploader :photo_mult, PhotoUploader

  attr_readonly :user_id, except: {on: :create}

  validates :user_id, presence: true, length: {maximum: 5000}
  validates :shareable_type, inclusion: {in: %w( Post )}, allow_nil: true
  validates :youtube_url, length: {maximum: 500}
  validate  :presence_of_content, :valid_content_combination, :disallow_private_event_share
  after_destroy :remove_from_list
  
##### Relations

  belongs_to :shareable, polymorphic: true

  def user
    User.find(self.user_id)
  end

  def sparkers
    User.find(self.sparker_ids)
  end

  def comments
    Comment.find(self.comment_ids)
  end

  def tagged_users
    User.find(self.tagged_user_ids)
  end

###

  def sparkers_count
    self.redcount(:sparker_ids)
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

  def sparker_ids
    self.redget(:sparker_ids)
  end

  def comment_ids
    self.redget(:comment_ids)
  end


  # def photo_mult
  #   _mounter(:photos).uploader
  #   self.photos.map{|f| super(f)}
  # end

  # def photo_mult=(array=[])
  #   self.photos = array
  # end

private

  def valid_content_combination
    return unless (photos.present? && shareable_type.present?)      ||
                  (photos.present? && youtube_url.present?)         ||
                  (shareable_type.present? && youtube_url.present?)
    errors.add(:base, "Don't post a photo and share content!")
  end

  def presence_of_content
    return unless  body.blank?            &&  
                   photos.blank?          &&  
                   shareable_type.blank?  &&  
                   youtube_url.blank?

    errors.add(:base, "Try posting something!")
  end

  def disallow_private_event_share
    return unless self.shareable_type == "Event"
    if self.shareable.public == false
      errors.add(:base, "You cannot share a private event.")
    else
      return
    end
  end

  def remove_from_list
    self.user.remove(:owned_post_ids, self.id)
  end
end

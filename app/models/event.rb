class Event < ActiveRecord::Base
  include PGArrayMethods
  include RedArrayMethods
  attr_readonly :user_id
  
  validates :address, :user_id, :start_time, :end_time, presence: true
  validates :name, presence: true, length: {maximum: 60}
  validates :body, presence: true, length: { maximum: 3000 }
  validates :public, inclusion: [true, false]
  validate  :presence_of_content
  
  after_validation :correct_times

  after_destroy :remove_from_list

##### Relations

  def user
    User.find(self.user_id)
  end

  def sparkers
    User.find(self.sparker_ids)
  end

  def comments
    Comment.find(self.comment_ids)
  end

  def added_users
    User.find(self.added_user_ids)
  end

  def invited_users
    User.find(self.invited_user_ids)
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

  def added_user_count
    self.redcount(:added_user_ids)
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

  def added_user_ids
    self.redget(:added_user_ids)
  end

##### Actions

  def invite!(users=[])
    self.append_mult(:invited_user_ids, users.map(&:id))
    users.map{|u| u.append(:invited_event_ids, self.id)}
  end

  def uninvite_user!(user)
    self.remove(:invited_user_ids, user.id)
    self.redremove(:added_user_ids, user.id)
    user.remove(:invited_event_ids, self.id)
    user.remove(:added_event_ids, self.id)
  end

private

  def presence_of_content
    return if (self.youtube_url.present? ^ self.photos.present?)
    errors.add(:base, "Need at least one photo or a video!")
  end

  def correct_times
    if self.start_time.nil?  ||  self.end_time.nil?
      errors.add(:base, 'Need event start and end times!')
    elsif (self.start_time + 24.hours) < self.end_time  ||  self.end_time < self.start_time  ||  self.start_time < Time.now
      errors.add(:base, 'Incorrect event times!')
    else
    end
  end

  def remove_from_list
    self.user.remove(:owned_event_ids, self.id)
  end
end

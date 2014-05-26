class Message < ActiveRecord::Base
  self.synchronous_commit(false) # true for push notifs?
  attr_readonly :user_id, :conversation_id

  # mount_uploader :photo, PhotoUploader

  validates :user_id, :conversation_id, presence: true
  validates :body, length: {maximum: 5000}
  validate :presence_of_content
  # after_commit :set_to_unread      #=> Faye
  
  def user
    User.find(self.user_id)
  end

  def conversation
    Conversation.find(self.conversation_id)
  end

  def recipients	
    self.conversation.conversation_users
  end

private

  def presence_of_content
    return if self.photo.present?  ||  self.body.present?
    errors.add(:base, "Don't send a blank message!")
  end
end

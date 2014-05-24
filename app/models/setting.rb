class Setting < ActiveRecord::Base

  alias_attribute :user_id, :id

  validates :user_id, presence: true
  validates :follower_approval, :email_notifications, :lock_all_self_content, inclusion: { in: [true, false]}

  def user
	User.find(self.user_id)
  end
end

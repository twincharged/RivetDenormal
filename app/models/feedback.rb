class Feedback < ActiveRecord::Base


  attr_readonly :user_id, except: {on: :create}
  
  validates :user_id, :body, presence: true
  validates :user_id, uniqueness: {scope: :subject} ###### PLEASE DON'T SEND THE SAME MESSAGE TWICE!
  validates :subject, length: {maximum: 100}
  validates :body, length: {maximum: 2500}
  validate  :eliminate_feedback_spam
  
  
  def user
    User.find(self.user_id)
  end
  
private

  def eliminate_feedback_spam
    time = Time.now - 1.minutes
    if Feedback.where("user_id = ? AND created_at > ?", self.user_id, time).load.any?
       errors.add(:user_id, 'Can only send feedback once a minute!')
    end
  end

end

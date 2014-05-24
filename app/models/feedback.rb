class Feedback < ActiveRecord::Base


  attr_readonly :user_id, except: {on: :create}
  
  validates :user_id, :body, presence: true
  validates :subject, length: {maximum: 100}
  validates :body, length: {maximum: 2500}
  validate  :eliminate_feedback_spam
  
  
  def user
    User.find(self.user_id)
  end
  
private

  def eliminate_feedback_spam
    time = Time.now - 30.seconds
    if Feedback.where("user_id = ? AND created_at > ?", self.user_id, time).load.any?
       errors.add(:user_id, 'Can only send feedback once every thirty seconds!')
    end
  end

end

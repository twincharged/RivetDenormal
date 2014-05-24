class Group < ActiveRecord::Base
  include PGArrayMethods
  self.synchronous_commit(false)

  validates :user_id, :name, presence: true
  validates :name, presence: true, length: {maximum: 60}

##### Relations

  def user
  	User.find(self.user_id)
  end

  def group_users
  	User.find(self.group_user_ids)
  end

##### Actions

  def add_users!(users=[])
    self.append_mult(:group_user_ids, users.map(&:id))
  end

end

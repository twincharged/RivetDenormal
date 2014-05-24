class Comment < ActiveRecord::Base
  include PGArrayMethods
  include RedArrayMethods
  
  self.synchronous_commit(false)
  attr_readonly :user_id, except: {on: :create}

  validates :user_id, :threadable_id, :threadable_type, presence: true
  validates :body, presence: true, length: { maximum: 500 }
  validates :threadable_type, inclusion: {in: %w( Post Event )}

  before_save :verify_id_not_blocked, on: [:create, :update]
  after_destroy :remove_from_list

##### Relations

  belongs_to :threadable, polymorphic: true

  def user
    User.find(self.user_id)
  end

  def tagged_users
    User.find(self.tagged_user_ids)
  end

  def sparkers
  	User.find(self.sparker_ids)
  end

###

  def sparkers_count
    self.redcount(:sparker_ids)
  end

  def flag_count
    self.flagger_ids.count
  end
  
###

  def sparker_ids
    self.redget(:sparker_ids)
  end

private

  def remove_from_list
    self.threadable.redremove(:comment_ids, self.id)
  end

  def verify_id_not_blocked
    return unless self.threadable.user.blocked_user_ids.include?(self.user_id)
    errors.add(:base, "You are not allowed to comment on this user's post.")
  end

end

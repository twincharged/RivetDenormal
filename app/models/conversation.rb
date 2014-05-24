class Conversation < ActiveRecord::Base
  include PGArrayMethods
  self.synchronous_commit(false)

##### Relations

  def owner
  	User.find(self.owner_id)
  end

  def conversation_users
  	User.find(self.conversation_user_ids)
  end

  def messages
  	Message.find(self.message_ids)
  end

##### Actions

  def add_users!(users=[])
    self.append_mult(:conversation_user_ids, users.map(&:id))
  end

end

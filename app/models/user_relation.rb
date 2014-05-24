class UserRelation < ActiveRecord::Base
	include PGArrayMethods
	synchronous_commit(false)
	alias_attribute :user_id, :id
end

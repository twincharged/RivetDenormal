class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|

      # primary id of user_relations is equal to the corresponding user id
      
      t.integer :owned_post_ids,          array: true, default: []
      t.integer :owned_group_ids,         array: true, default: []
 
      t.integer :in_conversation_ids,     array: true, default: []

      t.integer :followed_ids,            array: true, default: []
      t.integer :follower_ids,            array: true, default: []
      t.integer :pending_follower_ids,    array: true, default: []
      t.integer :flagger_ids,             array: true, default: []
 
      # t.integer :owned_notification_ids,  array: true, default: []     #=> Redis/Faye to do.
      # t.integer :owned_comment_ids,       array: true, default: []     #=> Not nesccessary. Index via GIN if so.
      # t.integer :liked_post_ids,        array: true, default: []     #=> Not nesccessary. Index via GIN if so.

      t.timestamps
    end
  end
end

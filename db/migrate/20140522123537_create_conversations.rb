class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.boolean :started_by_entity, default: false

      t.integer :owner_id
      t.integer :conversation_user_ids, array: true, default: []
      t.integer :message_ids, array: true, default: []

      t.timestamps
    end
  end
end

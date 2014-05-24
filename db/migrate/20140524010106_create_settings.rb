class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :follower_approval, default: false
      t.boolean :email_notifications, default: true
      t.boolean :lock_all_self_content, default: false


      t.timestamps
    end
    add_index :settings, [:id, :follower_approval]
  end
end

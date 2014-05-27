class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :fullname
      t.string  :university
      t.string  :gender
      t.date    :birthday
      t.text    :description, limit: 500
      t.boolean :entity, default: false
      t.boolean :moderator, default: false
      t.boolean :deactivated, default: false
      t.string  :avatar
      t.string  :backdrop

      t.timestamps
    end
    add_index :users, :university
  end
end

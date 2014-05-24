class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer    :reply_to_user_id
      t.text       :body, null: false
      t.string     :photo
      t.references :threadable, polymorphic: true

      t.integer    :user_id
      t.integer    :tagged_user_ids, array: true, default: []
      t.integer    :flagger_ids, array: true, default: []
      
      # t.integer :sparker_ids, array: true, default: []          #=> Redis

      t.timestamps
    end
  end
end

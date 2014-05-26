class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text     :body, limit: 3000
      t.string   :name
      t.boolean  :public, default: false
      t.string   :address
      t.boolean  :special, default: true
      t.datetime :start_time
      t.datetime :end_time
      t.string   :photo
      t.string   :youtube_url

      t.integer  :user_id
      t.integer  :tagged_user_ids, array: true, default: []
      t.integer  :invited_user_ids, array: true, default: []
      t.integer  :flagger_ids, array: true, default: []

      # t.integer :added_user_ids, array: true, default: []        #=> Redis
      # t.integer :sparker_ids, array: true, default: []           #=> Redis
      # t.integer :comment_ids, array: true, default: []           #=> Redis

      t.timestamps
    end
    add_index :events, :user_id
  end
end

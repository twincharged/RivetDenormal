class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text       :body
      t.boolean    :public, default: false
      t.string     :youtube_url
      t.string     :photo

      t.integer    :user_id
      t.references :shareable, polymorphic: true
      t.integer    :tagged_user_ids, array: true, default: []
      t.integer    :flagger_ids, array: true, default: []

      # t.integer :liker_ids, array: true, default: []         #=> Redis
      # t.integer :comment_ids, array: true, default: []         #=> Redis

      t.timestamps
    end
    add_index :posts, :user_id
  end
end

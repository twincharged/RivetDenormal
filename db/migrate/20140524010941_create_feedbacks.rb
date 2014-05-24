class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id, null: false
      t.text :subject
      t.text :body, null: false

      t.timestamps
    end
    add_index :feedbacks, :subject
    add_index :feedbacks, [:created_at, :user_id]
  end
end

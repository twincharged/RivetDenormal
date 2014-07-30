class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string  :username
      t.string  :fullname
      t.string  :gender
      t.date    :birthday
      t.text    :description, limit: 500
      t.boolean :entity, default: false
      t.boolean :moderator, default: false
      t.boolean :deactivated, default: false
      t.string  :avatar
      t.string  :backdrop

      t.timestamps

      execute "ALTER DATABASE rivetdev SET synchronous_commit TO OFF"
      execute "ALTER DATABASE rivettest SET synchronous_commit TO OFF"
      # execute "ALTER DATABASE rivetproduction SET synchronous_commit TO OFF"
    end
  end
end

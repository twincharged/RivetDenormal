class CreateBans < ActiveRecord::Migration
  def change
    create_table :bans do |t|
      t.string  :email
      t.text    :ban_report

      t.timestamps
    end
    add_index :bans, :email
  end
end

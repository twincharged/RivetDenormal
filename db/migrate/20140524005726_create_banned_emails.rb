class CreateBannedEmails < ActiveRecord::Migration
  def change
    create_table :banned_emails do |t|
      t.string  :email
      t.text    :ban_report

      t.timestamps
    end
    add_index :banned_emails, :email
  end
end

class AddEmailRemindersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allow_email_reminders, :boolean, default: true
    add_column :users, :email_reminders_days, :integer, default: 1
  end
end

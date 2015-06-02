namespace :todo do
  desc "This task deletes expired items (items older than 7 days)."
  task delete_expired: :environment do
    deleted = Item.expired_items.destroy_all
    puts "#{deleted.count} expired items destroyed successfully."
  end

  desc "This task generates the summary emails and queues them to send"
  task generate_summary_emails: :environment do
    # Find which users are due to recieve their emails at current time (6am their local time)
    # and preload all their associated items amd to see if they need to recieve emails on any
    # and preload their timezones to see how much longer the item has befor expiring
    users_for_email = User.users_for_summary_email_at_6.preload(:items, :time_zone)
    
    # Check if any of the items need to be included in the summary email
    users_for_email.each do |user|
      items = []
      user.items.each do |item|
        if (item.expires_at - user.email_reminders_days.days) < Time.now.utc
          items << item
        end
      end
      
      # If there are items that need to be mailed send the email
      if !items.empty?
        TodoMailer.todo_summary_email(user, items).deliver_now
      end
    end
  end
end

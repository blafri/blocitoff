namespace :todo do
  desc "This task deletes expired items (items older than 7 days)."
  task delete_expired: :environment do
    deleted = Item.expired_items.destroy_all
    puts "#{deleted.count} expired items destroyed successfully."
  end

  desc "This task generates the summary emails and queues them to send"
  task generate_summary_emails: :environment do
    User.includes(:time_zone, :items).users_for_summary_email.each do |user|
      items = []
      user.items.each do |item|
        if (item.expires_at - user.email_reminders_days.days) < Time.now.utc
          items << item
        end
      end
      TodoMailer.todo_summary_email(user, items).deliver_now
    end
  end
end

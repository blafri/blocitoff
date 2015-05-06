namespace :todo do
  desc "This task deletes expired items (items older than 7 days)."
  task delete_expired: :environment do
    deleted = Item.expired_items.destroy_all
    puts "#{deleted.count} expired items destroyed successfully."
  end

end

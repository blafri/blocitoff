# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed the time_zones table with time zone info
ActiveSupport::TimeZone.all.each do |zone|
  TimeZone.create!(name: zone.tzinfo.identifier, description: zone.to_s, utc_offset: zone.utc_offset)
end
puts "Database time_zones table seeded successfully"

if Rails.env.development?
  require 'faker'
  
  # Create Users
  user = User.new(
    first_name: 'blayne',
    last_name:  'farinha',
    email:      'blayne.farinha@gmail.com',
    password:   'C00lness',
    time_zone:  TimeZone.find_by_name("America/La_Paz")
  )
  user.skip_confirmation!
  user.save!
  
  user = User.new(
    first_name: 'blayne',
    last_name:  'farinha',
    email:      'b_farinha1985@hotmail.com',
    password:   'C00lness',
    time_zone:  TimeZone.find_by_name("America/La_Paz")
  )
  user.skip_confirmation!
  user.save!
  users = User.all
  puts "#{users.count} users created"
  
  # Create Items
  days_old = (0..8).to_a
  100.times do
    item = Item.new(
      user: users.sample,
      name: Faker::Lorem.sentence(3, true, 0)
    )
    item.expires_at = (days_old.sample.days.ago.in_time_zone(item.user.configured_time_zone) + 7.days).beginning_of_day
    item.save!
  end
  puts "#{Item.count} items created"
end
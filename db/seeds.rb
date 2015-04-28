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
  9.times do
    name = Faker::Name.name.split(' ', 2)
    user = User.new(
      first_name: name.shift,
      last_name:  name.shift,
      email:      Faker::Internet.email,
      password:   Faker::Lorem.characters(8)
    )
    user.skip_confirmation!
    user.save!
  end
  
  # Create a user I can login as
  user = User.new(
    first_name: 'blayne',
    last_name:  'farinha',
    email:      'blayne.farinha@gmail.com',
    password:   'C00lness'
  )
  user.skip_confirmation!
  user.save!
  users = User.all
  puts "#{users.count} users created"
  
  # Create Items
  100.times do
    Item.create!(
      user: users.sample,
      name: Faker::Lorem.sentence(3, true, 0)
    )
  end
  puts "#{Item.count} items created"
end
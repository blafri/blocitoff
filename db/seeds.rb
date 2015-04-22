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

class TimeZone < ActiveRecord::Base
  has_many :users
  
  default_scope { order('utc_offset ASC') }
  
  # Grabs all time zones where the current local time is in the same hour as the value passed in
  # @param hour [Fixnum] the hour for the local time in the timezone
  # @return [Array] an array of time zones objects where the local time is at the hour
  #   you passed in
  def self.current_local_zone_hour_is(hour)
    zones = []
    ActiveSupport::TimeZone.all.each do |zone|
      if Time.now.in_time_zone(zone.tzinfo.identifier).hour == hour
        zones << zone.tzinfo.identifier
      end
    end
    zones
  end
end

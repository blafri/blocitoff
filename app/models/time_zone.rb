class TimeZone < ActiveRecord::Base
  has_many :users
  
  default_scope { order('utc_offset ASC') }
end

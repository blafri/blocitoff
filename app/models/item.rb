class Item < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  validates :user, presence: true
  
  def days_left
    days = (expiration_date.to_date - Time.now.in_time_zone(user.configured_time_zone).to_date).to_i
    
    # Simply return zero if days is negative else return days
    days < 0 ? 0 : days
  end
  
  def expiration_date
    (created_at_with_time_zone + 7.days).beginning_of_day
  end
  
  def created_at_with_time_zone
    created_at.in_time_zone(user.configured_time_zone)
  end
end

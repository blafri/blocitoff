class Item < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  validates :user, presence: true
  validates :expires_at, presence: true
  
  scope :expired_items, -> { where("expires_at <= ?", Time.now.utc) }
  
  def days_left
    days = (in_time_zone(expires_at).to_date - in_time_zone(Time.now).to_date).to_i
    
    # Simply return zero if days is negative else return days
    days < 0 ? 0 : days
  end
  
  def set_expiration_date
    self.expires_at = (in_time_zone(Time.now) + 7.days).beginning_of_day
  end
  
  private
  
  def in_time_zone(time)
    time.in_time_zone(user.configured_time_zone)
  end
end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :first_name, presence: true
  validates :last_name,  presence: true
  
  belongs_to :time_zone
  has_many :items, dependent: :destroy
  
  scope :users_for_summary_email_at_6, -> {
    joins(:time_zone).
    where(allow_email_reminders: true).
    where(time_zones: {name: TimeZone.current_local_zone_hour_is(6)})
  }
  
  def full_name
    (first_name + ' ' + last_name).titleize
  end
  
  def configured_time_zone
    if time_zone
      time_zone.name
    else
      'Etc/UTC'
    end
  end
end

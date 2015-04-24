class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :first_name, presence: true
  validates :last_name,  presence: true
  
  belongs_to :time_zone
  has_many :items, dependent: :destroy
  
  def full_name
    (first_name + ' ' + last_name).titleize
  end
end

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    email 'john.doe@example.com'
    password 'Abcd1234'
    allow_email_reminders true
    email_reminders_days 1
    confirmed_at Time.now
    
    factory :user_with_time_zone do
      association :time_zone, factory: :trinidad_time_zone
    end
  end

end

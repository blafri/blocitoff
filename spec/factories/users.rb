FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    email 'john.doe@example.com'
    password 'Abcd1234'
    confirmed_at Time.now
  end

end

FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "item #{n}" }
    user
    expires_at { set_expiration_date }
    
    factory :item_2_days_old do
      expires_at { (2.days.ago.in_time_zone(user.configured_time_zone) + 7.days).beginning_of_day }
    end
    
    factory :item_10_days_old do
      expires_at { (10.days.ago.in_time_zone(user.configured_time_zone) + 7.days).beginning_of_day }
    end
  end

end

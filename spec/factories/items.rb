FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "item #{n}" }
    user
    
    factory :item_2_days_old do
      created_at { 2.days.ago }
      updated_at { 2.days.ago }
    end
  end

end

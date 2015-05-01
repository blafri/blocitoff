FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "item #{n}" }
    user
  end

end

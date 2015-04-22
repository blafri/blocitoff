FactoryGirl.define do
  factory :time_zone do
    sequence(:name) { |n| "timezone#{n}" }
    sequence(:description) { |n| "timezone description #{n}" }
    sequence(:utc_offset)
  end

end

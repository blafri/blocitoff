FactoryGirl.define do
  factory :time_zone do
    sequence(:name) { |n| "timezone#{n}" }
    sequence(:description) { |n| "timezone description #{n}" }
    sequence(:utc_offset)
    
    factory :trinidad_time_zone do
      name "America/La_Paz"
      description "(GMT-04:00) La Paz"
      utc_offset -14400
    end
  end

end

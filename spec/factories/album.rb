FactoryGirl.define do
  factory :album do
    association :user
    sequence(:name) { |n| "Summer Fun #{n}" }
  end
end

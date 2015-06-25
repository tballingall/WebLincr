FactoryGirl.define do
  factory :picture do
    association :album
    sequence(:name) { |n| "Summer Fun #{n}" }
    image Rack::Test::UploadedFile.new(
      'spec/support/files/kitten.jpg',
      'image/jpg'
    )
  end
end

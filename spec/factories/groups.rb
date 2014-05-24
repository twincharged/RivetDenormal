# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
  	user_id { FactoryGirl.create(:user).id }
  	name { Faker::Lorem.characters(20) }
  end
end

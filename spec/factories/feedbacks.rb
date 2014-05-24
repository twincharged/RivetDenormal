# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
  	user_id { FactoryGirl.create(:user).id }
  	subject Faker::Lorem.characters(50)
  	body Faker::Lorem.characters(150)
  end
end

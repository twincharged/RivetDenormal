# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
  	user_id { FactoryGirl.create(:user).id }
  	conversation_id { FactoryGirl.create(:user_conversation).id }
  	body { Faker::Lorem.characters(30) }
  	photo "app/assets/images/logo-white.png"
  end
end

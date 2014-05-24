# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :banned_email do
  	email { FactoryGirl.create(:user).email }
  	ban_report { Faker::Lorem.sentence(word_count = 100 ) }
  end
end

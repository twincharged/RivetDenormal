# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ban do
  	email { FactoryGirl.create(:user).email }
  	ban_report { Faker::Lorem.sentence(word_count = 100 ) }
  end
end

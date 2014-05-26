# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :public_event, class: "Event" do
    user_id { FactoryGirl.create(:user, entity: true).id }
    name { Faker::Lorem.characters(50) }
    body { Faker::Lorem.sentence(word_count = 10) }
    address "8417 Random st."
    start_time (Time.now + 24.hours)
    end_time (Time.now + 26.hours)
    photo {File.open("app/assets/images/logo-white.png")}
    public true
  end

  factory :private_event, class: "Event" do
    user_id { FactoryGirl.create(:user, entity: false).id }
    name { Faker::Lorem.characters(50) }
    body { Faker::Lorem.sentence(word_count = 10) }
    address "8417 Random st."
    start_time (Time.now + 20.hours)
    end_time (Time.now + 23.hours)
    photo {File.open("app/assets/images/logo-white.png")}  # EXAMPLE PHOTO
    public false
  end
end

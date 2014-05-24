# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
  	user_id { FactoryGirl.create(:user).id }
  	body { Faker::Lorem.sentence(word_count = 5) }
  	public true
  end

  factory :photo_post, class: "Post" do
  	user_id { FactoryGirl.create(:user).id }
  	body { Faker::Lorem.sentence(word_count = 5) }
  	photos [File.open("app/assets/images/logo-white.png")]
  	public true
  end

  factory :post_share_post, class: "Post" do
  	user_id { FactoryGirl.create(:user).id }
  	body { Faker::Lorem.sentence(word_count = 5) }
  	shareable { FactoryGirl.create(:post) }
  	public true
  end

  factory :event_share_post, class: "Post" do
  	user_id { FactoryGirl.create(:user).id }
  	body { Faker::Lorem.sentence(word_count = 5) }
  	shareable { FactoryGirl.create(:public_event) }
  	public true
  end

  factory :youtube_post, class: "Post" do
  	user_id { FactoryGirl.create(:user).id }
  	body { Faker::Lorem.sentence(word_count = 5) }
  	youtube_url "H0Fte50Mnxw"
  	public true
  end
end

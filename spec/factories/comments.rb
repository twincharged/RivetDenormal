# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_comment, class: "Comment" do
  	user_id { FactoryGirl.create(:user).id }
  	threadable { FactoryGirl.create(:post) }
  	body { Faker::Lorem.sentence(word_count = 10) }
    photo {File.open("public/logo-white.png")}
  end

end

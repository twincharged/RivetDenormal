# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.first_name {Faker::Name.first_name}
    f.last_name {Faker::Name.last_name}
    f.email {"#{first_name}#{last_name}@email.arizona.edu"}
    f.password "password"
    f.password_confirmation "password"
  end
end

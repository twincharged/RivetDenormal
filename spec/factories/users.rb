# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

reg = /\A[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*{3,17}\z/i

  factory :user do |f|
  	f.username {"#{Faker::Internet.user_name(specifier: reg)[0..17]}#{Random.rand(1...99)}"}
    f.first_name {Faker::Name.first_name}
    f.last_name {Faker::Name.last_name}
    f.email {"#{first_name}#{last_name}@email.arizona.edu"}
    f.password "password"
    f.password_confirmation "password"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

reg = /\A[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*{3,17}\z/i

  factory :user do |f|
  	f.username {"#{Faker::Internet.user_name(specifier: reg)[0..17]}#{Random.rand(1...99)}"}
    f.fullname {Faker::Name.name}
    f.email {"#{username}@email.arizona.edu"}
    f.password "password"
    f.password_confirmation "password"
  end
end

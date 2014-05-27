require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def self.create_user
    User.create(username: Faker::Internet.user_name, fullname: Faker::Name.name)
    # , email: "#{username}@email.arizona.edu", password: 'password', password_confirmation: 'password'
  end

  def test_creation
  	user = self.class.create_user
  	assert user.is_a?(User)
  end
end

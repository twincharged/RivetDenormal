require 'spec_helper'

describe UsersController do

  before do 
    @user ||= FactoryGirl.create(:user)
  end 

  describe "new user" do
    it "creates user" do
      post :create, user: FactoryGirl.create(:user)
    # User.last.should
    end
  end
end

require 'spec_helper'

describe Setting do


  describe "invalid attributes" do

    it "should require user" do
      FactoryGirl.build(:setting, user_id: nil).should_not be_valid
    end
  end


  describe "valid attributes" do

    it "should create setting" do
      user2 = FactoryGirl.create(:user)
      expect(user2.settings).to_not be_nil
    end

    it "should update setting" do
      user2 = FactoryGirl.create(:user)
      set = user2.settings
      set.toggle!(:lock_all_self_content)
      set.lock_all_self_content.should == true
    end
  end

  describe "methods" do

    it "should find user" do
      user2 = FactoryGirl.create(:user)
      settings = Setting.find(user2.id)
      settings.user.should == user2
    end
  end
end

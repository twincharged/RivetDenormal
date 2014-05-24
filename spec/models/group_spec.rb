require 'spec_helper'

describe Group do

  describe "validations" do

  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:name) }
  	it { should ensure_length_of(:name) }

  end

  describe "associations" do
    
  	it "should belong to user" do
  		FactoryGirl.create(:group).user.should_not be_nil
    end
  end

  describe "invalid attributes" do
    
    it "should require user" do
      FactoryGirl.build(:group, user_id: nil).should_not be_valid
    end

    it "should require name" do
      FactoryGirl.build(:group, name: nil).should_not be_valid
    end

  end


  describe "valid attributes" do
    
    it "should create group" do
      FactoryGirl.build(:group).should be_valid
    end
  end
end

require 'spec_helper'

describe Feedback do

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should ensure_length_of(:subject) }
  	it { should validate_presence_of(:body) }
  	it { should ensure_length_of(:body) }

  end

  
  describe "associations" do
    
  	it "should belong to user" do
  		f = FactoryGirl.create(:feedback)
  		f.user.should_not be_nil
    end
  end


  describe "invalid attributes" do

  	it "should require user" do
  	  FactoryGirl.build(:feedback, user_id: nil).should_not be_valid
  	end

  	it "should require body" do
  	  FactoryGirl.build(:feedback, body: nil).should_not be_valid
  	end
  end
  

  describe "valid attributes" do

  	it "should create feedback" do
  	  FactoryGirl.build(:feedback).should be_valid
  	end
  end
end

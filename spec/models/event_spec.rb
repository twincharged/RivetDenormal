require 'spec_helper'

describe Event do


  before(:all) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @user4 = FactoryGirl.create(:user)
    @user5 = FactoryGirl.create(:user)
  end
  
  describe "validations" do

    it { should have_readonly_attribute(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should ensure_length_of(:body) }
    it { should ensure_length_of(:name) }

  end

  describe "invalid attributes" do

    it "should require user" do
      FactoryGirl.build(:public_event, user_id: nil).should_not be_valid
    end
   
    it "should require body" do
      FactoryGirl.build(:public_event, body: nil).should_not be_valid
    end
   
    it "should require address" do
      FactoryGirl.build(:public_event, address: nil).should_not be_valid
    end
   
    it "should require start time" do
      FactoryGirl.build(:public_event, start_time: nil).should_not be_valid
    end
   
    it "should require end time" do
      FactoryGirl.build(:public_event, end_time: nil).should_not be_valid
    end

    it "should require one day time period" do
      FactoryGirl.build(:public_event, start_time: Time.now + 2.hours, end_time: Time.now + 28.hours).should_not be_valid
    end

    it "should require time to be current or later" do
      FactoryGirl.build(:public_event, start_time: Time.now - 2.hours, end_time: Time.now + 2.hours).should_not be_valid
    end

    it "should require greater than end time" do
      FactoryGirl.build(:public_event, start_time: Time.now + 2.hours, end_time: Time.now - 2.hours).should_not be_valid
    end
   
    it "should require name" do
      FactoryGirl.build(:public_event, name: nil).should_not be_valid
    end
   
    it "should require name length" do
      name = "long name" * 10
      FactoryGirl.build(:public_event, name: name).should_not be_valid
    end

    it "should require correct content" do
      FactoryGirl.build(:public_event, youtube_url: "Hs2W3Rt5n").should_not be_valid
      FactoryGirl.build(:public_event, photo: nil).should_not be_valid
    end
  end


  describe "valid attributes" do

    it "should create event" do
      FactoryGirl.create(:public_event).should be_valid
    end

    it "should create with photo" do
      FactoryGirl.create(:public_event, youtube_url: nil).should be_valid
    end

    it "should create with youtube" do
      FactoryGirl.create(:public_event, photo: nil, youtube_url: "Hs2W3Rt5n").should be_valid
    end
  end


  describe "relations" do

    it "should create event <~> user" do
      event = @user2.create_event!(FakerAtts.public_event)
      event.user.should == @user2
    end

    it "should create event <~> sparkers" do
      event = @user1.create_event!(FakerAtts.public_event)
      @user2.spark!(event)
      @user3.spark!(event)
      event.sparkers.should include(@user2, @user3)        # sparks are cached so array is reloaded for testing
    end

    it "should create event <~> tagged_users" do
      attrs = FakerAtts.public_event
      attrs[:tagged_user_ids] = [@user1.id, @user3.id]
      event = @user2.create_event!(attrs)
      event.tagged_users.should include(@user1, @user3)
    end

    it "should create event <~> comments" do
      event = @user5.create_event!(FakerAtts.private_event)
      comment1 = @user1.create_comment!(event, body: "Testing... 1, 2, 3....")
      comment2 = @user2.create_comment!(event, body: "Testing... 1, 2, 3....")
      event.comments.should include(comment1, comment2)            # comments are cached so array is reloaded for testing
    end

  end
  

  describe "actions" do


    it "should invite users" do
      users = [@user2, @user3, @user4]
      event = @user1.create_event!(FakerAtts.private_event)
      event.invite!(users)
      event.invited_users.should include(@user2, @user3, @user4)
      users.map{|u| u.invited_events.should include(event)}
    end

    it "should uninvite user" do
      event = @user1.create_event!(FakerAtts.private_event)
      event.invite!([@user2, @user3])
      event.uninvite_user!(@user2)
      event.invited_users.should_not include(@user2)
      event.invited_users.should include(@user3)
      event.added_users.should_not include(@user2)
      @user2.invited_events.should_not include(event)
      @user3.invited_events.should include(event)
      @user2.added_events.should_not include(event)
    end


  end




end

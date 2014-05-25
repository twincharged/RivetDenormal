require 'spec_helper'
require 'debugger'

describe User do

  before(:all) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @user4 = FactoryGirl.create(:user)
    @user5 = FactoryGirl.create(:user)
  end


  describe "validations" do

    it { should validate_presence_of(:username)}
    it { should ensure_length_of(:username) }
    it { should validate_uniqueness_of(:username)}
    it { should validate_presence_of(:email) }
    it { should ensure_length_of(:first_name) }
    it { should ensure_length_of(:last_name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password) }

  end


  describe "invalid attributes" do

    it "should require email" do
      FactoryGirl.build(:user, email: "").should_not be_valid
    end
  
    it "should require username" do
      FactoryGirl.build(:user, username: "").should_not be_valid
    end
  
    it "should reject lengthy first names" do
      lengthy_name = "long" * 6
      FactoryGirl.build(:user, first_name: lengthy_name).should_not be_valid
    end
  
    it "should reject first name" do
      invalid_users = ["invalid_fname1", "2not valid", "@invalid3", "4invalid:", "5invalid?", "_invalid6", "/invalid7", "|invalid8", "invalid\9", "invalid{10"]
      invalid_users.each do |invalid_users|
      FactoryGirl.build(:user, first_name: invalid_users).should_not be_valid
      end
    end
    
    it "should reject lengthy username" do
      lengthy_name = "long" * 6
      FactoryGirl.build(:user, username: lengthy_name).should_not be_valid
    end
  
    it "should reject lengthy last names" do
      lengthy_name = "long" * 6
      FactoryGirl.build(:user, last_name: lengthy_name).should_not be_valid
    end
  
    it "should reject last names" do
      invalid_users = ["invalid_fname1", "2not valid", "@invalid3", "4invalid:", "5invalid?", "_invalid6", "/invalid7", "|invalid8", "invalid\9", "invalid''10"]
      invalid_users.each do |invalid_users|
      FactoryGirl.build(:user, last_name: invalid_users).should_not be_valid
      end
    end

    it "should reject usernames" do
      invalid_users = ["invalid fname1", "2not*valid", "@invalid}3", "4invalid:", "5invalid?", "|_invalid6", "/invalid7", "|inval'id8", "invalid+9", "invalid!10"]
      invalid_users.each do |invalid_users|
      FactoryGirl.build(:user, username: invalid_users).should_not be_valid
      end
    end

  ##### INVALID PASSWORD #####
  
    it "should require password" do
      FactoryGirl.build(:user, password: "").should_not be_valid
    end
  
    it "should reject lengthy passwords" do
      lengthy_password = "longpassword" * 5
      FactoryGirl.build(:user, password: lengthy_password).should_not be_valid
    end
  
    it "should reject short passwords" do
      FactoryGirl.build(:user, password: "short").should_not be_valid
    end

    it "should reject password mismatch" do
      invalid = ["CoolKid119", "iheartfalloutboy2", "Im pretty nifty", "0xboxsucks0", "Why so serious", "Ima show you how great I am."]
      invalid.each do
        FactoryGirl.build(:user, password: "#{invalid}", password_confirmation: "very #{invalid}").should_not be_valid
      end
    end
  
  ##### INVALID GENDER #####
  
    it "should reject genders" do
      FactoryGirl.build(:user, gender: "SHIM").should_not be_valid
    end
  
  ##### INVALID BDAY #####
  
    # it "should reject birthdays that are invalid" do
    #   FactoryGirl.build(:user, birthday: "YESTERDAY").should_not be_valid
    # end
  end
  

  describe "valid attributes" do

  	it "should create valid user" do
  		FactoryGirl.create(:user).should be_valid
  	end
  
    it "should accept email" do
      valid_emails = ["jhran@email.arizona.edu", "egnog@email.asu.edu", "zachf@email.seas.harvard.edu", "jimbo@email.stanford.edu"]
      valid_emails.each do |valid_emails|
      FactoryGirl.build(:user, email: valid_emails).should be_valid
      end
    end
  
    it "should accept first name" do
      valid_users = ["John", "Matt", "Amit", "Hassan-Al", "McClain", "L'Trell"]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, first_name: valid_users).should be_valid
      end
    end
  
    it "should accept last name" do
      valid_users = ["Smith", "Freal", "Case", "El-Ar", "McCormick", "L'Neal"]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, last_name: valid_users).should be_valid
      end
    end
  
    it "should accept password" do
      valid_users = ["CoolKid119", "iheartfalloutboy2", "Im pretty nifty", "0xboxsucks0", "Why so serious", "Ima show you how great I am."]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, password: valid_users, password_confirmation: valid_users).should be_valid
      end
    end

    it "should accept username" do
      valid_users = ["CoolKid119", "iheartfalloutboy2", "Im_pretty_nifty", "0xboxsucks0", "Why-so-serious", "Ima.show.you.how.grt"]
      valid_users.each do |valid_users|
      FactoryGirl.build(:user, username: valid_users).should be_valid
      end
    end
  
    it "should not require description" do
      FactoryGirl.build(:user, description: nil).should be_valid
    end
  
    it "should accept entity" do
      FactoryGirl.build(:user, entity: true).should be_valid
    end
  
    it "should accept moderator" do
      FactoryGirl.build(:user, moderator: true).should be_valid
    end
  
    it "should accept deactivated" do
      FactoryGirl.build(:user, deactivated: true).should be_valid
    end
  
    it "should create setting" do
      valid_user = FactoryGirl.create(:user)
      Setting.find_by(user_id: valid_user.id).should_not be_nil
    end

  end

  describe "relations" do

    it "should follow user" do
      @user1.follow!(@user5)
      @user1.followed.should include(@user5)
      @user5.followers.should include(@user1)
    end

    it "should unfollow user" do
      @user1.follow!(@user5)
      @user1.unfollow!(@user5)
      @user1.followed.should_not include(@user5)
      @user5.followers.should_not include(@user1)
    end

    it "should create user <~> post" do
      post = @user1.create_post!(FakerAtts.public_post)
      @user1.posts.should include(post)
      post.user.should == @user1
    end

    it "should remove user <~> post" do
      post = @user1.create_post!(FakerAtts.public_post)
      post.destroy
      @user1.posts.should_not include(post)
    end

    it "should create user <~> event" do
      event = @user1.create_event!(FakerAtts.public_event)
      @user1.events.should include(event)
      event.user.should == @user1
    end

    it "should remove user <~> event" do
      event = @user1.create_event!(FakerAtts.private_event)
      event.destroy
      @user1.events.should_not include(event)
    end

    it "should create user <~> comment" do
      post = FactoryGirl.create(:post)
      comment = @user1.create_comment!(post , FakerAtts.comment)
      comment.user.should == @user1
    end

    it "should create user <~> group" do
      group = @user3.create_group!([@user4, @user2], name: "Bffs")
      group.group_users.should include(@user4, @user2)
    end

    it "should create user <~sparks~> post" do
      post = @user5.create_post!(FakerAtts.public_post)
      @user2.spark!(post)
      post.sparkers.should include(@user2)
    end

    it "should create user <~sparks~> event" do
      event = @user3.create_event!(FakerAtts.public_event)
      @user4.spark!(event)
      event.sparkers.should include(@user4)
    end

    it "should create user <~sparks~> comment" do
      comment = @user3.create_comment!(FactoryGirl.create(:post), body: "Testing... 1, 2, 3....")
      @user4.spark!(comment)
      comment.sparkers.should include(@user4)
    end

    it "should remove user <~sparks~> post" do
      post = @user5.create_post!(FakerAtts.public_post)
      @user2.spark!(post)
      @user2.unspark!(post)
      post.sparkers.should_not include(@user2)
    end

    it "should remove user <~sparks~> event" do
      event = @user3.create_event!(FakerAtts.public_event)
      @user4.spark!(event)
      @user4.unspark!(event)
      event.sparkers.should_not include(@user4)
    end

    it "should remove user <~sparks~> comment" do
      comment = @user3.create_comment!(FactoryGirl.create(:post), body: "Testing... 1, 2, 3....")
      @user4.spark!(comment)
      @user4.unspark!(comment)
      comment.sparkers.should_not include(@user4)
    end

    it "should add public_event" do
      event = @user3.create_event!(FakerAtts.public_event)
      @user4.add_event!(event)
      event.added_users.should include(@user4)
      @user4.added_events.should include(event)
    end

    it "should add private_event" do
      event = @user3.create_event!(FakerAtts.private_event)
      event.invite!([@user4])
      event.added_users.should_not include(@user4)
      event.invited_users.should include(@user4)
      @user4.added_events.should_not include(event)
      @user4.invited_events.should include(event)
      @user4.add_event!(event)
      @user4.added_events.should include(event)
      @user4.invited_events.should_not include(event)
      event.added_users.should include(@user4)
      event.invited_users.should_not include(@user4)
    end

    it "should dismiss public_event" do
      event = @user3.create_event!(FakerAtts.public_event)
      @user4.add_event!(event)
      @user4.remove_event!(event)
      event.added_users.should_not include(@user4)
      @user4.added_events.should_not include(event)
    end

    it "should dismiss private_event" do
      event = @user3.create_event!(FakerAtts.private_event)
      event.invite!([@user4])
      @user4.add_event!(event)
      @user4.remove_event!(event)
      event.invited_users.should_not include(@user4)
      event.added_users.should_not include(@user4)
      @user4.invited_events.should_not include(event)
      @user4.added_events.should_not include(event)
    end

  end
end


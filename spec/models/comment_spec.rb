require 'spec_helper'

describe Comment do

  before(:all) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
  end

  describe "validations" do

  	it { should have_readonly_attribute(:user_id) }
  	it { should validate_presence_of(:user_id) }
  	it { should validate_presence_of(:threadable_id) }
  	it { should validate_presence_of(:threadable_type) }
  	it { should ensure_inclusion_of(:threadable_type).in_array(%w( Post Event )) }
  	it { should validate_presence_of(:body) }
  	it { should ensure_length_of(:body) }

  end
  

  describe "associations" do
    
    it "should belong to user" do
      FactoryGirl.create(:post_comment).user.should_not be_nil
    end

    it "should respond to sparks" do
      comment = FactoryGirl.create(:post_comment)
      @user1.spark!(comment)
      comment.sparker_ids.should include(@user1.id)
    end

  end


  describe "invalid attributes" do

  	it "should require user" do
  	  FactoryGirl.build(:post_comment, user_id: nil).should_not be_valid
  	end

  	it "should require threadable" do
  	  FactoryGirl.build(:post_comment, threadable_type: nil, threadable_id: nil).should_not be_valid
  	  FactoryGirl.build(:event_comment, threadable_type: nil, threadable_id: nil).should_not be_valid
  	end

  	it "should require body" do
  	  FactoryGirl.build(:post_comment, body: nil).should_not be_valid
  	end
  end


  describe "valid attributes" do

  	it "should manually create comment" do
  	  FactoryGirl.build(:post_comment).should be_valid
  	  FactoryGirl.build(:event_comment).should be_valid
  	end

    it "should methodically create post comment" do
      user = FactoryGirl.create(:user)
      post = FactoryGirl.create(:post)
      post.comments_count.should == 0
      user.create_comment!(post, body: "I'm a comment!")
      post.comments_count.should == 1
    end

    it "should methodically create event comment" do
      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:private_event)
      event.comments_count.should == 0
      user.create_comment!(event, body: "I'm another comment!")
      event.comments_count.should == 1
    end
  end
end

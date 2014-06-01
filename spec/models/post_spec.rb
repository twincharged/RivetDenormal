require 'spec_helper'

describe Post do



  before(:all) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
    @user4 = FactoryGirl.create(:user)
    @user5 = FactoryGirl.create(:user)
  end


 describe "validations" do

    it { should have_readonly_attribute(:user_id) }
    it { should validate_presence_of(:user_id) }
    
  end
  

  describe "associations" do

    it { should respond_to(:shareable) }

  end


  describe "invalid attributes" do

    it "should require user" do
      FactoryGirl.build(:post, user_id: nil).should_not be_valid
    end

    it "should require content" do
      FactoryGirl.build(:post, body: nil).should_not be_valid
    end

    it "should not share private event" do
      event = FactoryGirl.create(:private_event)
      post = FactoryGirl.build(:post, shareable: event).should_not be_valid
    end

    it "should require correct content" do
      event = FactoryGirl.create(:public_event)
      FactoryGirl.build(:photo_post, youtube_url: "H0Fte50Mnxw").should_not be_valid
      FactoryGirl.build(:photo_post, shareable: event).should_not be_valid
      FactoryGirl.build(:youtube_post, shareable: event).should_not be_valid
    end

  end


  describe "valid attributes" do

    it "should create post" do
      FactoryGirl.build(:post).should be_valid
    end

    it "should create post with body" do
      FactoryGirl.build(:post, body: 'WELL HELLO').should be_valid
    end

    it "should create post with photo" do
      file = File.open("public/logo-white.png")
      FactoryGirl.build(:post, photo: file).should be_valid
    end

    it "should share post with youtube" do
      FactoryGirl.build(:youtube_post).should be_valid
    end

    it "should add to share count" do
      shared_post = FactoryGirl.create(:post)
      post = @user1.share_post!(shared_post, body: "I'm sharing!")
      post.should be_valid
      shared_post.share_count.should == 1
    end
  end


  describe "relations" do

    it "should create post <~> user" do
      post = @user2.create_post!(body: "Testing... 1, 2, 3....")
      post.user.should == @user2
    end

    it "should create post <~> sparkers" do
      post = @user1.create_post!(body: "Testing... 1, 2, 3....")
      @user2.spark!(post)
      @user3.spark!(post)
      post.sparkers.should include(@user2, @user3)
    end

    it "should create post <~> tagged_users" do
      post = @user2.create_post!(body: "Testing... 1, 2, 3....", tagged_user_ids: [@user1.id, @user3.id])
      post.tagged_users.should include(@user1, @user3)
    end

    it "should create post <~> comments" do
      post = FactoryGirl.create(:post)
      comment1 = @user1.create_comment!(post ,body: "Testing... 1, 2, 3....")
      comment2 = @user1.create_comment!(post ,body: "Testing... 1, 2, 3....")
      post.comments.should include(comment1, comment2)
    end

  end

end
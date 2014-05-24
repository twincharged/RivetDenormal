require 'spec_helper'

describe Conversation do

  before(:all) do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user3 = FactoryGirl.create(:user)
  end

  describe "fields" do

  	it { should respond_to(:started_by_entity) }

  end


  describe "associations" do

    it "should respond to messages" do
      mess = @user1.create_conversation_and_message!([@user2, @user3], body: "haha")
      mess.conversation.should_not be_nil
      mess.conversation.conversation_users.should include(@user2, @user2)
    end

  end


  describe "(for a new conversation)" do

    it "should deliver messages" do
      user = FactoryGirl.create(:user)
      users = FactoryGirl.create_list(:user, 4)
  	  mess = user.create_conversation_and_message!(users, body: "This is a new conversation!!!")
  	  users.each do |f|
  	    f.received_messages(mess.conversation).should include(mess)
  	    f.relations.in_conversation_ids.should include(mess.conversation_id)
  	  end
    end


    it "should create reply" do
      user = FactoryGirl.create(:user)
      users = FactoryGirl.create_list(:user, 4)
      mess = user.create_conversation_and_message!(users, body: "This is a new conversation!!!")
      user2 = users.last
  	  mess2 = user2.send_message!(mess.conversation, body: 'watup')
  	  users.each do |f|
  		f.received_messages(mess.conversation).should include(mess2)
      end
    end

    it "should create new conversation for own group" do
      user = FactoryGirl.create(:user)
      group = FactoryGirl.create(:group, user_id: user.id)
      gus = group.group_users
      mess = user.create_conversation_and_message!(gus, body: "Invited all my buddies to chat!")
      gus.each do |f|
        f.received_messages(mess.conversation).should include(mess)
      end
    end
  end


end

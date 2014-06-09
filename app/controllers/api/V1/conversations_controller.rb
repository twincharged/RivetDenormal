module Api
  module V1


class ConversationsController < ApplicationController
  respond_to :json
  before_action :set_user, except: []
  # before_action :set_conv, except: [:create, :index]
  # before_action :authenticate_user! #, except: [:new, :create, :show, :index]

  def create
    @user.create_conversation_and_message!(new_conv_params[:conversation_user_ids], new_message_attrs)
  end

  def update
    @user.send_message!(@conv.id, new_message_attrs)
  end

  def user_conversations
    @conversations = @user.conversations
    respond_with({conversations: @conversations})
  end

  def conversation
    @mess = @conv.messages
    @user = @conv.owner
    @cu = @conv.conversation_users
    @response = {messages: @mess, owner: @user, conversation_users: @cu}
    respond_with(@response)
  end

private

  # def set_conv
  #   @conv = Conversation.find(params[:id])
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def new_conv_params
    params.require(:conversation).permit(:owner_id, :conversation_user_ids, :message_ids)
  end

  def new_message_attrs
    params.require(:message).permit(:body, :photo, :user_id, :conversation_id)
  end

  # def existing_conv_params
  #   params.require(:conversation).permit(:conversation_id, :conversation_user_ids, :message_ids, :owner_id, :started_by_entity)
  # end

end


  end
end
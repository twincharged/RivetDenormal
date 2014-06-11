module Api
  module V1


class EventsController < ApplicationController
  respond_to :json
  before_action :set_user

  def user_events
    @events = @user.events
    @response = {events: @events}
    respond_with(@response)
  end

  def added_user_events
    @added = @user.added_events
    respond_with({addedEvents: @added})
  end

  def invited_user_events
    @invited = @user.invited_events
    respond_with({invitedEvents: @invited})
  end

private

  def set_user
    @user = User.find(params[:id])
  end
end

  end
end
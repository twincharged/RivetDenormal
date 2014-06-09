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

private

  def set_user
    @user = User.find(params[:id])
  end
end

  end
end
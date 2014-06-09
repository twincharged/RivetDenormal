module Api
  module V1


class UsersController < ApplicationController
  respond_to :json
  before_action :set_user

private

  def set_user
    @user = User.find(params[:user_id])
  end
end

  end
end
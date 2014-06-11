module Api
  module V1


class GroupsController < ApplicationController
  respond_to :json
  before_action :set_user, except: []
  # before_action :set_group, except: [:create, :index]
  # before_action :authenticate_user! #, except: [:new, :create, :show, :index]

  def create
    @user.create_group!(new_group_params[:group_user_ids], {name: new_group_params[:name]})
  end

  def user_groups
    @groups = @user.groups
    respond_with({groups: @groups})
  end

private

  # def set_group
  #   @group = group.find(params[:id])
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def new_group_params
    params.require(:group).permit(:user_id, :group_user_ids, :name)
  end

end


  end
end
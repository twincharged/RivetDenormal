module Api
  module V1


class UsersController < ApplicationController
  respond_to :json
  before_action :set_user, except: [:create, :index]
  # before_action :authenticate_user! #, except: [:new, :create, :show, :index]

  def create
    @user = User.new(signup_params)
    if @user.save
      sign_in @user
      respond_to do |format|
      	format.json { render json: @user }
      end
    else
      # render :new
    end
  end

  def index
    respond_with(User.all.order("created_at DESC"))
  end

  def show
    respond_with(@user)
  end

  def update
    if @user.update(user_edit_params)
      respond_to do |format|
        format.json { render json: @user }
      end
    end
  end

  def destroy
    @user.update(deactivated: true)
  end

  def following
    @users = @user.followed
    respond_with(@users)
  end

  def followers
    @users = @user.followers
    respond_with(@users)
  end

  def profile
    @posts = @user.posts
    @response = {user: @user, posts: @posts}
    respond_with(@response)
  end

  def near_users
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def signup_params
    params.require(:user).permit(:username, :fullname, :email, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:avatar, :avatar_cache, :backdrop, :username, :fullname, :description, :birthday, :gender, :password, :password_confirmation) 
  end

end


  end
end
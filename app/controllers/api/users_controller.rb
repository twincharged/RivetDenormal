module API

class UsersController < ApplicationController
  respond_to :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_filter :authenticate_user! #, except: [:new, :create, :show, :index]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      sign_in @user
      respond_to do |format|
      	format.json { render json: @user }
      end
    else
      render :new
    end
  end

  def index
    respond_with(User.all.order("created_at DESC"))
  end

  def show
  	@user = User.find(params[:id])
    @response = {user: @user, posts: @user.posts}
    respond_with(@response)
  end

  def edit
    if request.xhr? && @user.update_attributes(user_edit_params)
      redirect_to :back
    else
      render :edit
    end
  end

  def update
    @user ||= User.find(params[:id])
    if @user.update(user_edit_params)
      respond_to do |format|
        format.json { render json: @user }
      end
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followed
    respond_with(@users)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    respond_with(@users)
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
    respond_with(@posts)
  end

  def near_users
    # @users = current_user.closeby_users.paginate(page: params[:page])
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def signup_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def user_edit_params
      params.require(:user).permit(:avatar, :avatar_cache, :backdrop, :first_name, :last_name, :description, :birthday, :gender, :password, :password_confirmation) 
    end

end
end
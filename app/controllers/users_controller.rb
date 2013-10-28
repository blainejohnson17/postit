class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create]
  before_action :require_owner, only: [:edit, :update]
  before_action :require_admin, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'You are registered and logged in.'
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'The user was successsfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  private

  def user_params
    if admin?
      params.require(:user).permit(:username, :password, :admin)
    else
      params.require(:user).permit(:username, :password)
    end
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_owner
    access_denied unless owner?(@user)
  end
end
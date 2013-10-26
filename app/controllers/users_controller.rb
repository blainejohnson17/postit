class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create]
  before_action :require_owner, only: [:edit, :update]

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

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_owner
    if !owner?(@user)
      flash[:error] = 'You must own the profile to do that.'
      redirect_to root_path
    end
  end
end
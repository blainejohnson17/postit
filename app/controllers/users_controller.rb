class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create]
  before_action :require_owner, only: [:edit, :update]
  before_action :require_admin, only: [:index, :destroy]

  def index
    @users =  User.paginate(params[:page]).order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def show
    @posts =  @user.posts.paginate(:page => params[:posts_page], :per_page => 10).order('created_at DESC')
    @comments = @user.comments.paginate(:page => params[:comments_page], :per_page => 10).order('created_at DESC')
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
      params.require(:user).permit(:username, :password, :time_zone, :admin)
    else
      params.require(:user).permit(:username, :password, :time_zone)
    end
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_owner
    access_denied unless owner?(@user)
  end
end
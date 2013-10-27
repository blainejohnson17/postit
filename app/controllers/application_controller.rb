class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def require_user
    access_denied unless logged_in?
  end

  def admin?
    current_user.role == 'admin'
  end
  helper_method :admin?

  def require_admin
    access_denied unless admin?
  end

  def access_denied
    flash[:error] = 'Must be logged in to do that.'
    redirect_to root_path
  end

  def creator?(obj)
    current_user == obj.creator
  end
  helper_method :creator?

  def owner?(user)
    current_user == user
  end
  helper_method :owner?

  def set_post
    @post = Post.find_by(slug: (params[:post_id] || params[:id]))
  end

  def categories
    @categories ||= Category.all
  end
  helper_method :categories
end

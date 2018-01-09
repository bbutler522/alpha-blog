class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  # Return current user if current user already exists, if not find the user based on the user id in the session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Return true if there is a current user
  def logged_in?
    !!current_user
  end
  
  # If user is not logged in when checking for an action, let them know and redirect
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end

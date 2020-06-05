class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # used for restricting access to unauthorized users
  before_action :authorized
  helper_method :current_user
  layout 'application'

  # returns the user that is currently logged into the application
  def current_user
    if session[:user_id]
      @current_user ||= User.friendly.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  # checks if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  # checks if a user is authorized to view a page by checking if a user is logged in and if not logged in then return to home page
  def authorized
    redirect_to root_path unless logged_in?
  end
end

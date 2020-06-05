class SessionsController < ApplicationController

  # skips the authorization check in order to create a session
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  # Creates a session if the correct pair of email and password is provided
  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  # destroys a session when a user logs out
  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out!"
  end
end

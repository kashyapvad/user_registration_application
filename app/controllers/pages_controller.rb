class PagesController < ApplicationController

  # skips the authorization check for home page and form submission for resetting password
  skip_before_action :authorized

  def home
  end

  def forgot_password
    @user = User.new
  end

  # Takes the submitted email by the user on forgot password page and checks whether a user exists in the database with that email
  # Sends the password reset link to the yser's email if the email exists in db
  def forgot_password_submit
    @user = User.where(:email => params[:user][:email].downcase).last
    if @user.nil?
      @email = params[:user][:email]
    else
      link_hash = LinkHash.find_or_create_by(:user_id => @user.id)
      link_hash.update(:updated_at => Time.now, :slug => SecureRandom.uuid)
      NotificationsMailer.with(user: @user).forgot_password.deliver_later
    end
  end
end

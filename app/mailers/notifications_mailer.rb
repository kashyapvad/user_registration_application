class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.signup.subject
  #
  def signup
    @user = params[:user]
    if Rails.env.development? or Rails.env.test?
      @link = "http://localhost:3000/login"
    elsif Rails.env.production?
      @link = "https://user-registration-incubit.herokuapp.com/login"
    end
    mail to: @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.forgot_password.subject
  #
  def forgot_password
    @user = params[:user]
    if Rails.env.development? or Rails.env.test?
      @link = "http://localhost:3000/reset_password/#{@user.link_hash.slug}"
    elsif Rails.env.production?
      @link = "https://user-registration-incubit.herokuapp.com/reset_password/#{@user.link_hash.slug}"
    end
    mail to: @user.email
  end
end

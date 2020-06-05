class UsersController < ApplicationController

  # skips the authorization check when signing up a user and creating session with password reset magic link
  skip_before_action :authorized, only: [:new, :create, :reset_password]

  before_action :set_user, only: [:show, :edit, :update]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.set_username
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        NotificationsMailer.with(user: @user).signup.deliver_later
        format.html {redirect_to root_path, notice: 'Sign Up was successful.'}
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:commit].eql? 'reset'
      @reset = true
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to root_path, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # Creates a session if the correct password reset link is provided by the user and renders the form to create new password
  def reset_password
    link_hash = LinkHash.where(:slug => params[:slug]).last
    if link_hash
      @user = link_hash.user
      if !link_hash.expired?
        session[:user_id] = @user.id
        @reset = true
        render 'edit'
      else
        render 'pages/link_expired'
      end
    else
      redirect_to root_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, you have signed up successfully!"
      redirect_to root_path, turbo_stream: true
    else
      flash[:alert] = "There was an error creating your account."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :firsName, :lastName, :address, :phone)
  end

  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end
end
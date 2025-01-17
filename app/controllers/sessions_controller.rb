class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_path, turbo_stream: true
    else
      flash[:alert] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to root_path
  end

  private

  def redirect_if_logged_in
    if session[:admin_id] || session[:user_id]
      redirect_to root_path, alert: "You are already logged in."
    end
  end
end

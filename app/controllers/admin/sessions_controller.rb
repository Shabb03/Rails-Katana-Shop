class Admin::SessionsController < Admin::ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create, :adminlogin]

  def new; end

  def adminlogin
    if session[:admin_id].present?
      redirect_to root_path, alert: "You are already logged in." and return
    end
  end

  def create
    admin = AdminUser.find_by(email: params[:email])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :adminlogin
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end

  private

  def redirect_if_logged_in
    if session[:admin_id].present? || session[:user_id].present?
      redirect_to root_path, alert: "You are already logged in."
    end
  end
end
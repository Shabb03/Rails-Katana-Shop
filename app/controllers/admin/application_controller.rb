module Admin
  class ApplicationController < ActionController::Base
    layout "admin"

    helper_method :current_admin, :admin_logged_in?, :current_user, :logged_in?, :admin_logged_in?
  
    private
  
    def authenticate_admin!
      redirect_to root_path, alert: "Access denied!" unless current_admin
    end
  
    def current_admin
      @current_admin ||= AdminUser.find(session[:admin_id]) if session[:admin_id]
    end

    def admin_logged_in?
      current_admin.present?
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      current_user.present?
    end
  end
end
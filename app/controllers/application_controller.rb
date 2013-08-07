class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

    def authenticate_user!
      redirect_to root_url, notice: 'Please log in to continue.' if current_user.nil?
    end

    def current_user
      unless @current_user
        if session[:user_id]
          @current_user = User.find_by_id(session[:user_id])
          session[:user_id] = nil if @current_user.nil?
        end
      end
      @current_user
    end
end

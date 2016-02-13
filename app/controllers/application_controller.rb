class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #after_filter :clear_flash


  include SessionHelper

  def clear_flash
    flash[:notice] = nil
    flash[:error]  = nil
    flash[:danger] = nil
  end

  
  private
  def log_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end

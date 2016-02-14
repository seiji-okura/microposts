module SessionHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
  
  def logged_in_user
    if !logged_in?
      redirect_to login_path
    end
  end
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end

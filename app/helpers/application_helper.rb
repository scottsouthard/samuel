module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def logged_in?
    session[:user_id] != nil
  end

  def check_logged_in
    redirect_to root unless logged_in?
  end

end

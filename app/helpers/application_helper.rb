module ApplicationHelper

  def logged_in?
    session[:user_id] != nil
  end

  def authenticate_user!
    redirect_to root_path unless logged_in?
  end
  
end

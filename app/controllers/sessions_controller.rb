class SessionsController < ApplicationController

  def new
    render "login"
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    p params
    p "BUTTSSS"
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to :root
    else
      render "login"
    end
  end

  def logout
    session.clear
    redirect_to :root
  end
end

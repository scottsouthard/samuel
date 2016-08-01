class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:full_name, :username, :avatar, :email, :is_mentor, :password)
  end
end

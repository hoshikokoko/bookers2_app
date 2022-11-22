class UsersController < ApplicationController
  def show
    @users = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end

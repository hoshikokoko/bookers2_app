class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update ]
  
  def index
    @users = User.all
    @booker = current_user
    @booknew = Book.new
  end
  
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @booker = User.find(params[:id])
    @booknew = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if   @user.update(user_params)
      flash[:notice] = "You have updated user successfully!"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to  user_session_path
    end
  end
end

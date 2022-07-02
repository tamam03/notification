class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def users_params
    params.require(:user).permit(:name)
  end
end

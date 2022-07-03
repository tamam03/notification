class RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notice_follow(current_user)
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end

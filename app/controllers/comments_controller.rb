class CommentsController < ApplicationController
    
  def create
      @comment = current_user.comments.new(comment_params)
      @comment.save
      redirect_to request.referer
  end
  
  private
  
  def comment_params
      params.require(:comment).permit(:text, :post_id)
  end
end

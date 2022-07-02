class CommentsController < ApplicationController
    
  def create
      @post = Post.find(params[:post_id])
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.post_id = @post.id
      @comment.save
      @post.save_notice_comment(current_user, @comment.id)
      redirect_to request.referer
  end
  
  private
  
  def comment_params
      params.require(:comment).permit(:text, :post_id)
  end
end

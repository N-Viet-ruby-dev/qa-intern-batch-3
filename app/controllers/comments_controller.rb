class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:info] = "Your comment will be heard!"
    else
      flash[:danger] = "Your comment errors!"
    end
    redirect_to post_show_post_path(params[:comment][:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id, :post_id
  end
end

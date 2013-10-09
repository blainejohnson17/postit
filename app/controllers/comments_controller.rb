class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = User.first

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    else
      @post.reload
      render 'posts/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
class Comment < ActiveRecord::Base
  def create
    @post = Post.find(params[:post_id])
    @user = User.first
    @comment = @post.comments.new(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to post_path(@post), :notice 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
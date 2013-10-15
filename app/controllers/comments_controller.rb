class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update]
  before_action :set_comment, only: [:edit, :update]
  before_action :require_user, only: [:create]
  before_action :require_creator, only: [:edit, :update]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.creator = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      @post.reload
      render 'posts/show'
    end
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment was updated!'
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def require_creator
    if !creator?(@comment)
      flash[:error] = 'Must be the creator to do that.'
      redirect_to root_path
    end
  end
end
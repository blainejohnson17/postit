class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update ]
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'The post was succesfully updated.'
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :category_ids => [])
    end
end

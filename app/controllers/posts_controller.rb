class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse 
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
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
      redirect_to @post, notice: 'The post was succesfully updated.'
    else
      render :edit
    end
  end

  def vote
    @vote = @post.votes.create(creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html {
        if !@vote.save
          flash[:error] = 'You can only vote once per entry'
        end
        redirect_to :back
      }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, :category_ids => [])
  end

  def require_creator
    if !creator?(@post)
      flash[:error] = 'Must be the creator to do that.'
      redirect_to root_path
    end
  end
end
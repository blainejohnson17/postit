class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def show
    category = Category.find(params[:id])
    @posts = category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to posts_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
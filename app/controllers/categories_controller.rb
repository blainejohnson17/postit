class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:show]

  def show
    @posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def edit

  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to posts_path, notice: 'The category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: 'The category was succesfully updated.'
    else
      @category.reload
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by(slug: params[:id])
  end
end
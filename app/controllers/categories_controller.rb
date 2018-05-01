class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories #Category.where(user_id: current_user.id).all
  end

  def show
    @category = current_category
  end

  def new
    @category = Category.new
  end

  def edit
    @category = current_category
  end

  def create
    @category = Category.new
    @category.user = current_user
    @category.attributes = category_params

    if @category.valid?
      @category.save!
      redirect_to action: 'show', id: @category.id
    else
      render action: 'new'
    end
  end

  def update
    @category = current_category
    return unless @category

    @category.attributes = category_params

    if @category.valid?
      @category.save!
      redirect_to action: 'show', id: @category.id
    else
      render action: 'edit'
    end
  end

  def destroy
    @category = current_category
    return unless @category

    @category.destroy
    redirect_to action: 'index'
  end

  private

  def current_category
    result = Category.where(id: params[:id], user_id: current_user.id).first
    render_404 unless result
    result
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories #Category.where(user_id: current_user.id).all
  end

  def show
    @category = find_category
  end

  def new
    @category = Category.new
  end

  def edit
    @category = find_category
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
    @category = find_category
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
    @category = find_category
    return unless @category

    @category.destroy
    redirect_to action: 'index'
  end

  private

  def find_category
    result = Category.find_by(id: params[:id], user_id: current_user.id)
    render_404 unless result
    result
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

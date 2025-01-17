class Admin::CategoriesController < Admin::ApplicationController
  before_action :require_admin
  
  def new
    @category = Category.new
  end
    
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: 'Category was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the category. Please try again.'
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to root_path, notice: 'Category was successfully updated.'
    else
      flash.now[:alert] = 'There was an error updating the Category. Please try again.'
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path, notice: 'Category was successfully deleted.'
  end
    
  private
   
  def category_params
    params.require(:category).permit(:name, :description)
  end
    
  def require_admin
    redirect_to root_path unless current_admin
  end
end
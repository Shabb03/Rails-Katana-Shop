class Admin::ProductsController < Admin::ApplicationController
  before_action :require_admin
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)

    if params[:product][:image].present?
      uploaded_image = params[:product][:image]
      image_path = Rails.root.join('app/assets/images', uploaded_image.original_filename)
      File.open(image_path, 'wb') do |file|
        file.write(uploaded_image.read)
      end
      @product.image_url = uploaded_image.original_filename
    end

    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the product. Please try again.'
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if params[:product][:image].present?
      uploaded_image = params[:product][:image]
      image_path = Rails.root.join('app/assets/images', uploaded_image.original_filename)
      File.open(image_path, 'wb') do |file|
        file.write(uploaded_image.read)
      end
      @product.image_url = uploaded_image.original_filename
    end

    if @product.update(product_params)
      redirect_to root_path, notice: 'Product was successfully updated.'
    else
      flash.now[:alert] = 'There was an error updating the product. Please try again.'
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path, notice: 'Product was successfully deleted.'
  end
  
  private
 
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_count, :image_url)
  end
  
  def require_admin
    redirect_to root_path unless current_admin
  end
end  
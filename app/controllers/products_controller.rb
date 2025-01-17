class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in to add items to your cart."
      return
    end

    @product = Product.find(params[:id])
    if @product.stock_count.zero?
      redirect_to product_path(@product), alert: "Sorry, #{@product.name} is out of stock."
      return
    end
    
    cart = current_user.cart || current_user.create_cart(is_active: true)
    cart.update(is_active: true) unless cart.is_active
    cart_item = cart.cart_items.find_or_initialize_by(product: @product)

    cart_item.quantity ||= 0
    cart_item.quantity += 1
    if cart_item.save
      redirect_to product_path(@product), notice: "#{@product.name} added to cart!"
    else
      redirect_to product_path(@product), alert: "Failed to add #{@product.name} to cart."
    end
  end
end

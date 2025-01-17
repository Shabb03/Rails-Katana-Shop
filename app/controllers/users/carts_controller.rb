class Users::CartsController < ApplicationController
  before_action :set_cart

  def add_to_cart
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_by(product_id: product.id)

    if item
      item.increment!(:quantity)
    else
      @cart.cart_items.create(product: product, quantity: 1)
    end

    redirect_to users_cart_path, notice: "#{product.name} added to your cart."
  end

  def remove_from_cart
    item = @cart.cart_items.find_by(id: params[:id])

    if item
      item.destroy
      redirect_to users_cart_path, notice: "#{item.product.name} removed from your cart."
    else
      redirect_to users_cart_path, alert: "Item not found in cart."
    end
  end

  def show
    cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product) if cart.present?
  end

  def checkout
    cart = current_user.cart
    if cart.present? && cart.cart_items.any?
      total_price = cart.cart_items.sum { |item| item.product.price * item.quantity }
      order = Order.create!(
        user: current_user,
        status: "Completed",
        total_price: total_price,
        time: Time.now
      )

      cart.cart_items.each do |cart_item|
        product = cart_item.product
        if product.stock_count >= cart_item.quantity
          product.update!(stock_count: product.stock_count - cart_item.quantity)
        else
          cart_item.update!(quantity: product.stock_count)
          product.update!(stock_count: 0)
        end

        order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end

      cart.update!(is_active: false)
      cart.cart_items.destroy_all
      redirect_to users_orders_path(order), notice: "Checkout successful! Your order has been placed."
    else
      redirect_to users_cart_path, alert: "Your cart is empty. Please add items before checking out."
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
class Users::OrdersController < ApplicationController
  def index
    @orders = current_user.orders.includes(:order_items)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product)
  end
end
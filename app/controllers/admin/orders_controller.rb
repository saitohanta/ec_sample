class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if params[:order][:status] == "payment_waiting"
      @order.update(status: 0)
      @order_items.update(product_status: 1)
    elsif params[:order][:status] == "payment_confirmation"
      @order.update(status: 1)
      @order_items.update(product_status: 1)
    else
      @order.update(status: 4)
      @order_items.update(product_status: 3)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

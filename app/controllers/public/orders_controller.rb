class Public::OrdersController < ApplicationController
  def new #注文情報入力画面
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm #注文情報確認画面
    @order = Order.new(order_params)
      #現在の顧客に登録されている住所であれば
    if params[:order][:address_option] == "0"
      @order.ship_postcode = current_customer.postcode
      @order.ship_address = current_customer.address
      @order.ship_name = current_customer.last_name + current_customer.first_name
      #新規住所入力ならば
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.ship_postcode = @address.postcode
      @order.ship_address = @address.address
      @order.ship_name = @address.name
      #登録済住所から選択するならば
    elsif params[:order][:address_option] == "2"
      @order.ship_postcode = params[:order][:ship_postcode]
      @order.ship_address = params[:order][:ship_address]
      @order.ship_name = params[:order][:ship_name]
    else
      render 'new'
    end
      @cart_items = current_customer.cart_items.all
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderItem.new
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.quantity = cart_item.quantity
      @ordered_item.price = (cart_item.item.price*1.08).floor
      @ordered_item.order_id = @order.id
      @ordered_item.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @orders = Order.all
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
  end

private

  def order_params
    params.require(:order).permit(:customer_id,:status,:ship_name,:ship_postcode,:ship_address,:shipping_fee,:payment_method,:total_price)
  end
end

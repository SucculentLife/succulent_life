class Public::OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @addresses = current_user.addresses.all
  end

  def create
    order = Order.new(order_params)
    if order.save
      @cart_items = current_user.cart_items.all

      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = order.id
        @order_details.item_id = cart_item.item.id
        @order_details.price = cart_item.item.with_tax_price
        @order_details.amount = cart_item.amount
        @order_details.making_status = 0
        @order_details.save!
      end

      CartItem.destroy_all
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_user.postal_code
      @order.address = current_user.address
      @order.name = current_user.last_name + current_user.first_name
    elsif params[:order][:select_address] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.user_id = current_user.id
    end
      @cart_items = current_user.cart_items
      @order_new = Order.new
      render :confirm
  end

  def thanks
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:user_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end

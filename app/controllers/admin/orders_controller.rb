class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    redirect_to admin_order_path(@order.id)
  end

  def user_show
    @user = User.find(params[:id])
    @orders = @user.orders.page(params[:page]).per(10)
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
end

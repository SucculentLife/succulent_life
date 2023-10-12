class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)

    if user_signed_in?
      @cart_item.user_id = current_user.id
      @cart_item.item_id = cart_item_params[:item_id]
      if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
        cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
        cart_item.update(amount: cart_item.amount)
        redirect_to cart_items_path
      else
        @cart_item.save
        redirect_to cart_items_path
      end
    else
      flash[:notice] = "商品のご購入には会員登録が必要です。"
      redirect_to new_user_registration_path
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  private
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end
end

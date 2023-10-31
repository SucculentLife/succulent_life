class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(20).order(created_at: :desc)
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(8).order(created_at: :desc)
    end
  end

  def show
    @item = Item.find(params[:id])
    @photos = @item.photos
    @i = 0
    @cart_item = CartItem.new
  end
end

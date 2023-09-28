class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      params[:item][:images].each do |image|
        @item.photos.create(image: image, item_id: @item.id)
      end
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
    @photos = @item.photos
    @i = 0
  end

  def edit
    @item = Item.find(params[:id])
    @photos = @item.photos
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.photos.delete_all
      params[:item][:images].each do |image|
        @item.photos.create(image: image, item_id: @item.id)
      end
      redirect_to admin_item_path(params[:id])
    else
      render :edit
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, photos_attributes: [:image])
    end
end

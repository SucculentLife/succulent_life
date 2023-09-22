class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.photos.build()
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save!
        params[:item_photos][:image].each do |image|
          @item.photos.create(image: image, item_id: @item.id)
        end
        redirect_to root_path
      else
        @good.photos.build
        render :new
      end
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
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

class Public::AddressesController < ApplicationController
  before_action :authenticate_user!

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def index
    @address = Address.new
    @addresses = current_user.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private
    def address_params
      params.require(:address).permit(:name, :postal_code, :address, :user_id)
    end
end
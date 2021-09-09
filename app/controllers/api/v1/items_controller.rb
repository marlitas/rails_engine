class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      params[:per_page] = 20 if params[:per_page].nil?
      params[:page] = 1 if params[:page].nil?
      items = Item.paginate(page: params[:page], per_page: params[:per_page])
    else
      items = Merchant.find(params[:merchant_id]).items
    end
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def find
    items = Item.search(params[:name])
    render json: ItemSerializer.new(items)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    if Merchant.exists?(id: params[:merchant_id]) || params[:merchant_id].nil?
      item = Item.find(params[:id])
      item.update(item_params)
      render json: ItemSerializer.new(item), status: :accepted
    else
      render json: {error: 'merchant does not exist'}, status: :not_found
    end
  end

  def destroy
    item = Item.find(params[:id])
    Invoice.destroy(item.solo_invoice)
    item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end

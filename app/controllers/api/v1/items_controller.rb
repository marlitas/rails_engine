class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id].nil?
      params[:per_page] = 20 if params[:per_page].nil?
      params[:page] = 1 if params[:page].nil?
      items = Item.paginate(page: params[:page], per_page: params[:per_page])
    else
      items = Merchant.find(params[:merchant_id]).items
    end
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end

  def find
    items = Item.search(params[:name])
    render json: ItemSerializer.format_items(items)
  end
end

class Api::V1::ItemsController < ApplicationController
  def index
    params[:per_page] = 20 if params[:per_page].nil?
    params[:page] = 1 if params[:page].nil?
    items = Item.paginate(page: params[:page], per_page: params[:per_page])
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end
end

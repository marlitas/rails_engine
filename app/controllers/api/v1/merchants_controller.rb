class Api::V1::MerchantsController <ApplicationController
  def index
    params[:per_page] = 20 if params[:per_page].nil?
    params[:page] = 1 if params[:page].nil? || params[:page].to_i <= 0
    merchants = Merchant.paginate(page: params[:page], per_page: params[:per_page])

    render json: MerchantSerializer.new(merchants)
  end

  def show
    item = Item.find(params[:item_id]) unless params[:item_id].nil?
    if item.nil?
      merchant = Merchant.find(params[:id])
    else
      merchant = Merchant.find(item.merchant_id)
    end
    render json: MerchantSerializer.new(merchant)
  end

  def find
    merchant = Merchant.search(params[:name])
    render json: MerchantSerializer.new(merchant)
  end

  def revenue
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.revenue(merchant)
  end
end

class Api::V1::MerchantsController <ApplicationController
  def index
    params[:per_page] = 20 if params[:per_page].nil?
    params[:page] = 1 if params[:page].nil?
    merchants = Merchant.paginate(page: params[:page], per_page: params[:per_page])
    render json: MerchantSerializer.format_merchants(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.format_merchant(merchant)
  end

  def find
    merchant = Merchant.search(params[:name])
  end
end

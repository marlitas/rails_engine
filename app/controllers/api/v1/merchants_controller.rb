class Api::V1::MerchantsController <ApplicationController
  def index
    params[:per_page] = 20 if params[:per_page].nil?
    merchants = Merchant.all.limit(params[:per_page])
    render json: MerchantSerializer.format_merchants(merchants)
  end
end

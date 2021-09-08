class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  
  def self.revenue(merchant)
    {data:
      {
      id: "#{merchant.id}",
      type: 'merchant_revenue',
      attributes: {
        revenue: merchant.total_revenue
        }
      }
    }
  end
end

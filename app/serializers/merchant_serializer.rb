class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  def self.revenue(merchant)
    { data:
      {
        id: merchant.id.to_s,
        type: 'merchant_revenue',
        attributes: {
          revenue: merchant.total_revenue
        }
      } }
  end

  def self.top_revenue(merchants)
    { data:
      merchants.map do |merchant|
        {
          id: merchant.id.to_s,
          type: 'merchant_name_revenue',
          attributes: {
            name: merchant.name,
            revenue: merchant.revenue
          }
        }
      end }
  end
end

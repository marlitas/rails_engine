class MerchantSerializer
  def self.format_merchants(merchants)
    { data: merchants.map do |merchant|
      {
        id: "#{merchant.id}",
        type: 'merchant',
        attributes: {
          name: merchant.name
        }
      }
    end
    }
  end

  def self.format_merchant(merchant)
    {data:
      if merchant.nil?
        {message: 'No match found.'}
      else
        {
        id: "#{merchant.id}",
        type: 'merchant',
        attributes: {
          name: merchant.name
          }
        }
      end
    }
  end

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

class MerchantSerializer
  def self.format_merchants(merchants)
    { data: merchants.map do |merchant|
      {
        id: merchant.id,
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
        id: merchant.id,
        type: 'merchant',
        attributes: {
          name: merchant.name
          }
        }
      end
    }
  end

  def self.merchant_revenue(merchant)

  end
end

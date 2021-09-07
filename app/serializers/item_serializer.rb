class ItemSerializer
  def self.format_items(items)
    { data:
    if items.empty?
      {message: 'No match found.'}
    else
     items.map do |item|
       {
        id: "#{item.id}",
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
        }
      end
    end
    }
  end

  def self.format_item(item)
    {data:
      {
      id: "#{item.id}",
      type: 'item',
      attributes: {
        name: item.name,
        description: item.description,
        unit_price: item.unit_price,
        merchant_id: item.merchant_id
        }
      }
    }
  end
end

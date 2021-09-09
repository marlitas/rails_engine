class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.search(query)
    where('lower(name) like ?', "%#{query.downcase}%").order(:name)
  end

  def solo_invoice
    Invoice.single_item.find_all do |id|
      Invoice.find(id).items.include?(self)
    end
  end
end

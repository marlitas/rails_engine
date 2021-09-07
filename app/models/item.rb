class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.search(query)
    where('lower(name) like ?', "%#{query.downcase}%").order(:name)
  end
end

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.search(query)
    where('lower(name) like ?', "%#{query.downcase}%").order(:name).first
  end

  def total_revenue
    invoices.where('invoices.status = ?', 'shipped')
    .sum('invoice_items.quantity * invoice_items.unit_price').round(2)
  end
end

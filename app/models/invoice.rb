class Invoice < ApplicationRecord
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.single_item
    joins(:invoice_items)
    .select('invoices.*')
    .group('invoices.id')
    .having('count(invoice_items.invoice_id) = 1')
  end
end

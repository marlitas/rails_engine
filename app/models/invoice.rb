class Invoice < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def self.single_item
    joins(:invoice_items)
      .select('invoices.id')
      .group('invoices.id')
      .having('count(invoice_items.invoice_id) = 1')
      .pluck('invoices.id')
  end
end

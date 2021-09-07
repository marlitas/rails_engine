class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.weekly_revenue
    joins(invoice: :transactions)
    .where('invoices.status = ?', 'shipped')
    .where('transactions.result = ?', 'success')
    .select("SUM(invoice_items.unit_price * invoice_items.quantity) as revenue, date_trunc('week', invoices.updated_at) as week")
    .group("week")
    .order("week")
  end
end

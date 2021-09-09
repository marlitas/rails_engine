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

  def self.date_range_revenue(start, end_date)
    joins(invoice: :transactions)
    .where('invoices.status = ?', 'shipped')
    .where('transactions.result = ?', 'success')
    .where('invoices.updated_at >= ?', start.to_datetime)
    .where('invoices.updated_at <= ?', end_date.to_datetime)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.single_item_invoices
    joins(:invoice)
    .select('invoices.*')
    .group('invoices.id')
    .having('count(invoice_items.invoice_id) = 1')
  end
end

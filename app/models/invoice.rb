class Invoice < ApplicationRecord
  has_many :transactions
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
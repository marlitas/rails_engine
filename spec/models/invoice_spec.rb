require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through (:invoice_items)}
    it {should belong_to :merchant}
  end

  it 'can find invoices with only one item' do
    create_list(:item, 2)
    create_list(:invoice_shipped, 4)

    ii1 = create(:invoice_item, item: Item.first, invoice: Invoice.first)
    ii2 = create(:invoice_item, item: Item.second, invoice: Invoice.second)
    ii3 = create(:invoice_item, item: Item.first, invoice: Invoice.second)
    ii4 = create(:invoice_item, item: Item.first, invoice: Invoice.third)
    ii5 = create(:invoice_item, item: Item.second, invoice: Invoice.fourth)
    expect(Invoice.single_item).to eq([Invoice.third.id, Invoice.fourth.id, Invoice.first.id])
  end
end

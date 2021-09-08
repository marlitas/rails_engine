require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'class methods' do
    before(:each) do
      @invoice1 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 05))
      @invoice2 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 06))
      @invoice3 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 14 ))
      @invoice4 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 15))
      @invoice5 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 20))
      @invoice6 = create(:invoice_shipped, updated_at: DateTime.new(2012, 03, 22))
      @invoice7 = create(:invoice_packaged, updated_at: DateTime.new(2012, 03, 05))
      @invoice8 = create(:invoice_returned, updated_at: DateTime.new(2012, 03, 15))

      @transaction1 = create(:transaction, invoice: @invoice1)
      @transaction2 = create(:transaction_failed, invoice: @invoice2)
      @transaction3 = create(:transaction, invoice: @invoice3)
      @transaction4 = create(:transaction, invoice: @invoice4)
      @transaction5 = create(:transaction, invoice: @invoice5)
      @transaction6 = create(:transaction, invoice: @invoice6)
      @transaction7 = create(:transaction, invoice: @invoice7)
      @transaction8 = create(:transaction, invoice: @invoice8)


      @ii1 = create(:invoice_item, invoice: @invoice1, unit_price: 10.00, quantity: 2)
      @ii2 = create(:invoice_item, invoice: @invoice2, unit_price: 14.50, quantity: 2)
      @ii3 = create(:invoice_item, invoice: @invoice3, unit_price: 40.50, quantity: 1)
      @ii4 = create(:invoice_item, invoice: @invoice4, unit_price: 10.00, quantity: 1)
      @ii5 = create(:invoice_item, invoice: @invoice5, unit_price: 10.00, quantity: 2)
      @ii6 = create(:invoice_item, invoice: @invoice6, unit_price: 10.00, quantity: 2)
      @ii7 = create(:invoice_item, invoice: @invoice7, unit_price: 100.99, quantity: 1)
      @ii8 = create(:invoice_item, invoice: @invoice8, unit_price: 100.99, quantity: 1)
    end
    it 'can retrieve revenue by week' do
      result = InvoiceItem.weekly_revenue
      expect(result.first.revenue).to eq(20.00)
      expect(result.first.week).to eq(DateTime.new(2012, 03, 05))
      expect(result.last.revenue).to eq(40.00)
      expect(result.last.week).to eq(DateTime.new(2012, 03, 19))
    end

    it 'can retrieve revenue for date range' do
      expect(InvoiceItem.date_range_revenue("2012-03-06", "2012-03-20")).to eq(70.50)
    end
  end
end

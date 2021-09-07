require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through (:items)}
    it {should have_many(:invoices).through (:invoice_items)}
  end

  describe 'class methods' do
    before(:each) do
      @merchant1 = create(:merchant, name: 'Spark Dog')
      @merchant2 = create(:merchant, name: 'Spark Boy')
      @merchant3 = create(:merchant, name: 'Platypus')
    end

    describe 'search' do
      it 'can return first result in alphabetical order' do
        expect(Merchant.search('spark')).to eq(@merchant2)
      end

      it 'is case insensitive' do
        expect(Merchant.search('sPArk')).to eq(@merchant2)
      end

      it 'can return a partial match' do
        expect(Merchant.search('park')).to eq(@merchant2)
      end
    end
  end

  describe 'instance methods' do
    before(:each) do
      @merchant1 = create(:merchant, name: 'Spark Dog')
      @merchant3 = create(:merchant, name: 'Platypus')

      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant1)
      @item3 = create(:item, merchant: @merchant3)

      @invoice1 = create(:invoice_shipped, merchant: @merchant1)
      @invoice2 = create(:invoice_shipped, merchant: @merchant1)
      @invoice3 = create(:invoice_shipped, merchant: @merchant3)

      @ii1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: 10.00, quantity: 2)
      @ii2 = create(:invoice_item, item: @item2, invoice: @invoice2, unit_price: 15.50, quantity: 2)
      @ii2 = create(:invoice_item, item: @item3, invoice: @invoice3, unit_price: 100.00, quantity: 1)
    end

    describe 'revenue' do
      it 'can return the total revenue of a specific merchant' do
        expect(@merchant1.total_revenue).to eq(51.00)
      end

      it 'can only return revenue from shipped invoices' do
        invoice = create(:invoice_packaged, merchant: @merchant1)
        ii = create(:invoice_item, item: @item1, invoice: invoice, unit_price: 100.00, quantity: 1)
        
        expect(@merchant1.total_revenue).to eq(51.00)
      end
    end
  end
end

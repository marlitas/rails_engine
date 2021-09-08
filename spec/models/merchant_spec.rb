require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through (:items)}
    it {should have_many(:invoices).through (:invoice_items)}
  end

  describe 'class methods' do
    describe 'search' do
      before(:each) do
        @merchant1 = create(:merchant, name: 'Spark Dog')
        @merchant2 = create(:merchant, name: 'Spark Boy')
        @merchant3 = create(:merchant, name: 'Platypus')
      end

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

    describe 'Top revenue' do
      before(:each) do
        create_list(:merchant, 5)

        @item1 = create(:item, merchant: Merchant.first)
        @item2 = create(:item, merchant: Merchant.second)
        @item3 = create(:item, merchant: Merchant.third)
        @item4 = create(:item, merchant: Merchant.fourth)
        @item5 = create(:item, merchant: Merchant.fifth)

        @invoice1 = create(:invoice_packaged, merchant: Merchant.first)
        @invoice2 = create(:invoice_shipped, merchant: Merchant.second)
        @invoice3 = create(:invoice_shipped, merchant: Merchant.third)
        @invoice4 = create(:invoice_shipped, merchant: Merchant.fourth)
        @invoice5 = create(:invoice_shipped, merchant: Merchant.fifth)

        @transaction1 = create(:transaction_failed, invoice: @invoice4)
        @transaction2 = create(:transaction, invoice: @invoice1)
        @transaction3 = create(:transaction, invoice: @invoice2)
        @transaction4 = create(:transaction, invoice: @invoice3)
        @transaction5 = create(:transaction, invoice: @invoice5)


        @ii1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: 50.00, quantity: 2)
        @ii2 = create(:invoice_item, item: @item2, invoice: @invoice2, unit_price: 100.50, quantity: 2)
        @ii3 = create(:invoice_item, item: @item3, invoice: @invoice3, unit_price: 10.00, quantity: 1)
        @ii4 = create(:invoice_item, item: @item4, invoice: @invoice4, unit_price: 50.00, quantity: 2)
        @ii5 = create(:invoice_item, item: @item5, invoice: @invoice5, unit_price: 10.00, quantity: 2)
      end

      it 'can return array of merchants by revenue' do
        expect(Merchant.top_revenue(3)).to eq([Merchant.second, Merchant.fifth, Merchant.third])
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

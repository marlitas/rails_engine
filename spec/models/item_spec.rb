require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through (:invoice_items)}
  end

  describe 'class methods' do
    describe 'search' do
      before(:each) do
        @item1 = create(:item, name: 'Ball')
        @item2 = create(:item, name: 'Bouncy Ball')
        @item3 = create(:item, name: 'Baseball')
        @item4 = create(:item, name: 'Tomato')
      end
      it 'can return array of matches in alphabetical order' do
        expect(Item.search('Ball')).to eq([@item1, @item3, @item2])
      end

      it 'is case insensitive' do
        expect(Item.search('bAlL')).to eq([@item1, @item3, @item2])
      end

      it 'can return a partial match' do
        expect(Item.search('bal')).to eq([@item1, @item3, @item2])
      end
    end
  end

  describe 'instance methods' do
    describe 'solo invoice' do
      it 'can find all invoices where it is the only item' do
        create_list(:item, 2)
        create_list(:invoice_shipped, 4)

        ii1 = create(:invoice_item, item: Item.first, invoice: Invoice.first)
        ii2 = create(:invoice_item, item: Item.second, invoice: Invoice.second)
        ii3 = create(:invoice_item, item: Item.first, invoice: Invoice.second)
        ii4 = create(:invoice_item, item: Item.first, invoice: Invoice.third)
        ii5 = create(:invoice_item, item: Item.second, invoice: Invoice.fourth)

        expect(Item.first.solo_invoice).to eq([Invoice.first.id, Invoice.third.id])
      end
    end
  end
end

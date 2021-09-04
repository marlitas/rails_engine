require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
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
end

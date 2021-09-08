require 'rails_helper'

RSpec.describe 'Invoice Items API' do
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
  describe 'weekly revenue' do
    it 'can return weekly revenue' do
      get '/api/v1/revenue/weekly'
      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      revenue[:data].each do |week|
        expect(week).to have_key(:id)
        expect(week[:id]).to eq(nil)
        expect(week[:type]).to eq('weekly_revenue')
        expect(week).to have_key(:attributes)
        expect(week[:attributes]).to have_key(:week)
        expect(week[:attributes][:week]).to be_a(String)
        expect(week[:attributes]).to have_key(:revenue)
        expect(week[:attributes][:revenue]).to be_a(Float)
      end
    end

    it 'returns weekly revenue sorted by oldest first' do
      get '/api/v1/revenue/weekly'
      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue[:data].first[:attributes][:week]).to eq('2012-03-05')
      expect(revenue[:data].first[:attributes][:revenue]).to eq(20.00)
      expect(revenue[:data][1][:attributes][:week]).to eq('2012-03-12')
      expect(revenue[:data][1][:attributes][:revenue]).to eq(50.50)
      expect(revenue[:data].last[:attributes][:week]).to eq('2012-03-19')
      expect(revenue[:data].last[:attributes][:revenue]).to eq(40.00)
    end
  end

  describe 'total revenue over date range' do
    it 'can retrieve revenue for given date range' do
      get '/api/v1/revenue?start=2012-03-06&end=2012-03-20'
      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue[:data][:attributes][:revenue]).to eq(70.50)
    end

    it 'returns error if date params missing' do
      get '/api/v1/revenue'
      expect(response).to_not be_successful
    end

    it 'returns error if start params blank' do
      get '/api/v1/revenue?start=2012-03-06&end='
      expect(response).to_not be_successful
    end

    it 'returns error if end params blank' do
      get '/api/v1/revenue?start=&end=2012-03-20'
      expect(response).to_not be_successful
    end
  end
end

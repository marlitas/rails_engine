require 'rails_helper'

RSpec.describe 'Merchants API' do
   describe 'index' do
     before(:each) do
       create_list(:merchant, 100)
     end

     it 'sends default list of first 20 merchants' do
       get '/api/v1/merchants'

       expect(response).to be_successful

       merchants = JSON.parse(response.body, symbolize_names: true)

       expect(merchants[:data].count).to eq(20)

       merchants[:data].each do |merchant|
         expect(merchant).to have_key(:id)
         expect(merchant[:id]).to be_an(String)

         expect(merchant).to have_key(:type)
         expect(merchant[:type]).to eq('merchant')

         expect(merchant).to have_key(:attributes)
         expect(merchant[:attributes]).to be_a(Hash)

         expect(merchant[:attributes]).to have_key(:name)
         expect(merchant[:attributes][:name]).to be_a(String)

         expect(merchant[:attributes]).to_not have_key(:created_at)
         expect(merchant[:attributes]).to_not have_key(:updated_at)
       end
     end

     it 'sends list of first n merchants based on query input' do
       get '/api/v1/merchants?per_page=50'

       expect(response).to be_successful

       merchants = JSON.parse(response.body, symbolize_names: true)

       expect(merchants[:data].count).to eq(50)
     end

     it 'sends list of n merchants from x page' do
       get '/api/v1/merchants?per_page=50'
       expect(response).to be_successful

       merchants_1 = JSON.parse(response.body, symbolize_names: true)

       expect(merchants_1[:data].count).to eq(50)

       get '/api/v1/merchants?per_page=50&page=2'
       expect(response).to be_successful

       merchants_2 = JSON.parse(response.body, symbolize_names: true)

       expect(merchants_2[:data].count).to eq(50)
       expect(merchants_2[:data].first[:id]).to eq("#{merchants_1[:data].last[:id].to_i + 1}")

     end
   end

   describe 'show' do
     it 'can retrieve info on one merchant' do
       merchant = create(:merchant)

       get "/api/v1/merchants/#{merchant.id}"
       expect(response).to be_successful

       merchant_response = JSON.parse(response.body, symbolize_names: true)

       expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
       expect(merchant_response[:data][:type]).to eq('merchant')
       expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
     end
   end

   describe 'search' do
     before (:each) do
       @merchant1 = create(:merchant, name: 'Spark Dog')
       @merchant2 = create(:merchant, name: 'Spark Boy')
       @merchant3 = create(:merchant, name: 'Platypus')
     end

     it 'can retrieve object based on search params in alphabetical order' do
       get '/api/v1/merchants/find?name=spark'
       expect(response).to be_successful

       merchant = JSON.parse(response.body, symbolize_names: true)

       expect(merchant[:data][:attributes][:name]).to eq(@merchant2.name)
     end

     it 'returns message if no match found' do
       get '/api/v1/merchants/find?name=gibberish'
       expect(response).to be_successful

       merchant = JSON.parse(response.body, symbolize_names: true)

       # expect(merchant[:data][:message]).to eq('No match found.')
     end
   end

   describe 'total revenue' do
     before(:each) do
       @merchant = create(:merchant)

       @item1 = create(:item, merchant: @merchant)
       @item2 = create(:item, merchant: @merchant)

       @invoice1 = create(:invoice_shipped, merchant: @merchant)
       @invoice2 = create(:invoice_shipped, merchant: @merchant)

       @ii1 = create(:invoice_item, item: @item1, invoice: @invoice1, unit_price: 10.00, quantity: 2)
       @ii2 = create(:invoice_item, item: @item2, invoice: @invoice2, unit_price: 15.50, quantity: 2)
     end

     it 'returns total revenue for merchant' do
       get "/api/v1/revenue/merchants/#{@merchant.id}"
       expect(response).to be_successful

       merchant = JSON.parse(response.body, symbolize_names: true)

       expect(merchant[:data][:id]).to eq("#{@merchant.id}")
       expect(merchant[:data][:type]).to eq('merchant_revenue')
       expect(merchant[:data][:attributes][:revenue]).to eq(51.00)
       expect(merchant[:data][:attributes]).to_not have_key(:name)
     end
   end

   describe 'sorted merchants' do
     before(:each) do
       create_list(:merchant, 5)

       @invoice1 = create(:invoice_packaged, merchant: Merchant.first)
       @invoice2 = create(:invoice_shipped, merchant: Merchant.second)
       @invoice3 = create(:invoice_shipped, merchant: Merchant.third)
       @invoice4 = create(:invoice_shipped, merchant: Merchant.fourth)
       @invoice5 = create(:invoice_shipped, merchant: Merchant.fifth)

       @transaction = create(:transaction_failed, invoice: @invoice4)

       @ii1 = create(:invoice_item, invoice: @invoice1, unit_price: 50.00, quantity: 2)
       @ii2 = create(:invoice_item, invoice: @invoice2, unit_price: 100.50, quantity: 2)
       @ii3 = create(:invoice_item, invoice: @invoice3, unit_price: 10.00, quantity: 1)
       @ii4 = create(:invoice_item, invoice: @invoice4, unit_price: 50.00, quantity: 2)
       @ii5 = create(:invoice_item, invoice: @invoice5, unit_price: 10.00, quantity: 2)
     end

     it 'can return merchants sorted by revenue' do
       get '/api/v1/revenue/merchants?quantity=3'
       expect(response).to be_successful

       merchants = JSON.parse(response.body, symbolize_names: true)

       expect(merchant[:data].length).to eq(3)
       expect(merchant[:data].first[:attributes][:revenue]).to eq(201.00)
       expect(merchant[:data].last[:attributes][:revenue]).to eq(10.00)

       merchants[:data].each do |merchant|
         expect(merchant[:type]).to eq('merchant_name_revenue')
         expect(merchant[:attributes]).to have_key(:name)
         expect(merchant[:attributes][:name]).to be_a(String)
         expect(merchant[:attributes]).to have_key(:revenue)
         expect(merchant[:attributes][:revenue]).to be_a(Float)
       end
     end

     it 'returns error if quantity param missing' do
       get '/api/v1/revenue/merchants'
       expect(response).not_to be_successful
     end

     it 'returns error if quantity param is not integer' do
       get '/api/v1/revenue/merchants?quantity=4.2'
       expect(response).not_to be_successful
     end

     it 'returns error if quantity param is less than zero' do
       get '/api/v1/revenue/merchants?quantity=-2'
       expect(response).not_to be_successful
     end
   end

   describe 'associated items' do
     before(:each) do
       @merchant1 = create(:merchant)
       @merchant2 = create(:merchant)

       @item1 = create(:item, merchant: @merchant1)
       @item2 = create(:item, merchant: @merchant1)
       @item3 = create(:item, merchant: @merchant2)
     end

     it 'can retrieve all merchants items' do
       get "/api/v1/merchants/#{@merchant1.id}/items"
       expect(response).to be_successful

       items = JSON.parse(response.body, symbolize_names: true)

       expect(items[:data].length).to eq(2)
       items[:data].each do |item|
         expect(item[:attributes][:merchant_id]).to eq(@merchant1.id)
       end
     end

     it 'does not retrieve another merchants items' do
       get "/api/v1/merchants/#{@merchant1.id}/items"
       expect(response).to be_successful

       items = JSON.parse(response.body, symbolize_names: true)

       items[:data].each do |item|
         expect(item[:id]).to_not eq(@item3.id.to_s)
       end
     end
   end
end

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

       expect(merchants.count).to eq(20)

       merchants.each do |merchant|
         expect(merchant).to have_key(:id)
         expect(merchant[:id]).to be_an(Integer)

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

       expect(merchants.count).to eq(50)
     end

     it 'sends list of n merchants from x page' do
       get '/api/v1/merchants?per_page=50'

       expect(response).to be_successful

       merchants_1 = JSON.parse(response.body, symbolize_names: true)

       expect(merchants_1.count).to eq(50)

       get '/api/v1/merchants?per_page=50&page=2'

       expect(response).to be_successful

       merchants_2 = JSON.parse(response.body, symbolize_names: true)

       expect(merchants_2.count).to eq(50)

       expect(merchants_2.first[:id]).to eq(merchants_1.last[:id] + 1)

     end
   end
end

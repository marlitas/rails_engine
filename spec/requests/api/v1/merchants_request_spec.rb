require 'rails_helper'

RSpec.describe 'Merchants API' do
   describe 'index' do
     before(:each) do
       create_list(:merchant, 22)
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
   end
end

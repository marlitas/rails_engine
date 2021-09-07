require 'rails_helper'

RSpec.describe 'items requests' do
  describe 'index' do
    before(:each) do
      create_list(:item, 100)
    end

    it 'send default list of first 20 items' do
      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to_not have_key(:created_at)
        expect(item[:attributes]).to_not have_key(:updated_at)
      end
    end

    it 'sends list of first n items based on query input' do
      get '/api/v1/items?per_page=50'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(50)
    end

    it 'sends list of n items from x page' do
      get '/api/v1/items?per_page=50'
      expect(response).to be_successful

      items_1 = JSON.parse(response.body, symbolize_names: true)

      expect(items_1[:data].count).to eq(50)

      get '/api/v1/items?per_page=50&page=2'
      expect(response).to be_successful

      items_2 = JSON.parse(response.body, symbolize_names: true)

      expect(items_2[:data].count).to eq(50)
      expect(items_2[:data].first[:id]).to eq("#{items_1[:data].last[:id].to_i + 1}")

    end
  end

  describe 'show' do
    it 'can retrieve info for one item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"
      expect(response).to be_successful

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(item_response[:data][:id]).to eq("#{item.id}")
      expect(item_response[:data][:type]).to eq('item')
      expect(item_response[:data][:attributes][:name]).to eq(item.name)
      expect(item_response[:data][:attributes][:description]).to eq(item.description)
      expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    end
  end

  describe 'search' do
    before (:each) do
      @item1 = create(:item, name: 'Ball')
      @item2 = create(:item, name: 'Bouncy Ball')
      @item3 = create(:item, name: 'Baseball')
      @item4 = create(:item, name: 'Tomato')
    end

    it 'can retrieve items based on search params' do
      get '/api/v1/items/find?name=ball'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].first[:attributes][:name]).to eq(@item1.name)
      expect(items[:data].last[:attributes][:name]).to eq(@item2.name)
      expect(items[:data].length).to eq(3)
    end

    it 'returns message if no match found' do
      get '/api/v1/items/find?name=gibberish'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data][:message]).to eq('No match found.')
    end
  end
end

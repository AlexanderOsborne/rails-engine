require 'rails_helper'

RSpec.describe 'items search' do
  describe 'name param' do
    it 'finds a collection of items matching the search term' do
      merchant = create(:merchant)
      tacos = [create(:item, name: 'taco', merchant: merchant), create(:item, name: 'Deltacoria', merchant: merchant)]
      salsa = create(:item, name: 'salsa', merchant: merchant)

      get "/api/v1/items/find_all?name=taco"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data].count).to eq(2)
      expect(items[:data].pluck(:id)).to match_array(tacos.pluck(:id).map(&:to_s))


      items[:data].each do |item|
        expect(item).to be_a(Hash)
        expect(item.keys).to match_array(%i[id type attributes])
        expect(item[:attributes].keys).to match_array(%i[name description unit_price merchant_id])
      end
    end

    it 'returns an empty array if no items are not found' do
      merchant = create(:merchant)
      create(:item, merchant: merchant)

      get "/api/v1/items/find_all?name=NOMATCH"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_empty
    end

    it 'returns an empty array if no fragment is given' do
      merchant = create(:merchant)
      create(:item, merchant: merchant)

      get "/api/v1/items/find_all?name="

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data]).to be_empty
    end

    it 'returns a single item in an array if only one item is found' do
      merchant = create(:merchant)
      item = create(:item, name: "Cerveza", merchant: merchant)

      get "/api/v1/items/find_all?name=cerveza"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data].count).to eq(1)
    end
  end

  describe 'allows for optional price query params' do
    it 'accepts a min_price query' do
      merchant = create(:merchant)
      goldilocks_items = create_list(:item, 2, unit_price: 5.00, merchant: merchant)
      cheap_item = create(:item, unit_price: 1.00, merchant: merchant)

      get "/api/v1/items/find_all?min_price=5.00"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data].count).to eq(2)
      expect(items[:data].pluck(:id)).to match_array(goldilocks_items.pluck(:id).map(&:to_s))
    end

    it 'accepts a max_price query' do
      merchant = create(:merchant)
      included_items = create_list(:item, 2, unit_price: 1.00, merchant: merchant)
      excluded_item = create(:item, unit_price: 5.00, merchant: merchant)

      get "/api/v1/items/find_all?max_price=4.99"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data].count).to eq(2)
      expect(items[:data].pluck(:id)).to match_array(included_items.pluck(:id).map(&:to_s))
    end

    it 'accepts both min_price and max_price in the same request' do
      merchant = create(:merchant)
      included_items = [create(:item, unit_price: 5.00, merchant: merchant), create(:item, unit_price: 9.00, merchant: merchant)]
      excluded_items = [create(:item, unit_price: 3.00, merchant: merchant), create(:item, unit_price: 10.00, merchant: merchant)]

      get "/api/v1/items/find_all?max_price=9.99&min_price=4.99"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a(Hash)
      expect(items[:data].count).to eq(2)
      expect(items[:data].pluck(:id)).to match_array(included_items.pluck(:id).map(&:to_s))
    end
  end

  it 'returns an error if both text and price parameters are sent' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get "/api/v1/items/find_all?max_price=2.00&min_price=2.00&name=beer"

    expect(response.status).to eq(400)

    get "/api/v1/items/find_all?max_price=2.00&name=taco"

    expect(response.status).to eq(400)

    get "/api/v1/items/find_all?min_price=2.00&name=cerveza"

    expect(response.status).to eq(400)
  end

  it 'returns all items if neither a text or a price parameter are sent' do
    merchant = create(:merchant)
    create_list(:item, 12, merchant: merchant)

    get '/api/v1/items/find_all'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].size).to eq(12)
  end
end
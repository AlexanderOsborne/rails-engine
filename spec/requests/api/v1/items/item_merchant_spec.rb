require 'rails_helper'

RSpec.describe 'get a merchant by item id' do
  it 'gets the merchant of an item' do
    merchant1 = create(:merchant)
    id = create(:item, merchant: merchant1).id

    get "/api/v1/items/#{id}/merchant"
    
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant).to be_a(Hash)
    expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'returns a 404 if item is not found' do
    get "/api/v1/items/1/merchant"

    expect(response.status).to eq(404)

    get "/api/v1/items/one/merchant"

    expect(response.status).to eq(404)
  end
end
require 'rails_helper'
RSpec.describe 'Items', type: :request do

  it 'it sends a list of 20 items per page' do
    merchant = create(:merchant)
    create_list(:item, 25, merchant: merchant)

    get api_v1_items_path
    expect(response).to be_successful
    
    page1 = JSON.parse(response.body, symbolize_names: true)

    get '/api/v1/items?page=2'
    page2 = JSON.parse(response.body, symbolize_names: true)

    expect(page1[:data].size).to eq(20)
    expect(page2[:data].size).to eq(5)
  end

  it 'returns all items if less than 20' do
    merchant = create(:merchant)
    create_list(:item, 12, merchant: merchant)
    
    get '/api/v1/items?page=1'
    page1 = JSON.parse(response.body, symbolize_names: true)
    expect(page1[:data].size).to eq(12)
  end
end
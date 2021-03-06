require 'rails_helper'

RSpec.describe 'create an item' do
  it 'creates a new item' do
    merchant_id = create(:merchant).id
    item_params = attributes_for(:item).merge(merchant_id: merchant_id)
    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to be_a(Hash)
    expect(item[:data].keys).to match_array(%i[id type attributes])
    expect(item[:data][:attributes].keys).to match_array(%i[name description unit_price merchant_id])
    end

    it 'ignores any additional attributes sent by the user' do
      merchant_id = create(:merchant).id
      item_params = attributes_for(:item).merge(merchant_id: merchant_id, model_number: '28P1817074')
  
      headers = {'CONTENT_TYPE' => 'application/json'}
  
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
  
      expect(response).to be_successful
  
      created_item = Item.last
      expect(created_item).not_to have_attribute(:model_number)
  
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:data][:attributes].keys).to match_array(%i[name description unit_price merchant_id])
    end
  end
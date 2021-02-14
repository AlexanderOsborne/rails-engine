require 'rails_helper'

RSpec.describe 'update an item' do
  it 'updates an exiting item' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id
    previous_name = Item.last.name
    item_params = { name: "New Name!"}
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
    expect(response).to be_successful

    item = Item.find(id)
    expect(item.name).to eq(item_params[:name])
    expect(item.name).not_to eq(previous_name)


    body = JSON.parse(response.body, symbolize_names: true)

    expect(body).to be_a(Hash)
    expect(body[:data][:attributes][:name]).to eq(item_params[:name])
    expect(body[:data].keys).to match_array(%i[id type attributes])
    expect(body[:data][:attributes].keys).to match_array(%i[name description unit_price merchant_id])
  end

  it 'can update multiple attributes' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    previous_name = item.name
    previous_description = item.description
    previous_unit_price = item.unit_price
    previous_merchant_id = item.merchant_id
    new_merchant = create(:merchant)
    item_params = attributes_for(:item).merge(merchant_id: new_merchant.id)
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful

    item = Item.find(item.id)
    expect(item.name).to eq(item_params[:name])
    expect(item.name).not_to eq(previous_name)
    expect(item.description).to eq(item_params[:description])
    expect(item.description).not_to eq(previous_description)
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.unit_price).not_to eq(previous_unit_price)
    expect(item.merchant_id).to eq(item_params[:merchant_id])
    expect(item.merchant_id).not_to eq(previous_merchant_id)
  end

  it 'returns an error for a bad item id' do
    item_params = attributes_for(:item)
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/1", headers: headers, params: JSON.generate(item: item_params)

    expect(response.status).to eq(404)
  end

  # it 'returns an error for a bad merchant id' do
  #   merchant = create(:merchant)
  #   item = create(:item, merchant: merchant)
  #   item_params = { merchant_id: item.merchant_id + 1}
  #   headers = {'CONTENT_TYPE' => 'application/json'}

  #   patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

  #   expect(response.status).to eq(400)
  # end

  # it 'returns an error if all attributes are missing' do
  #   merchant = create(:merchant)
  #   item = create(:item, merchant: merchant)
  #   headers = {'CONTENT_TYPE' => 'application/json'}

  #   patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: {})

  #   expect(response.status).to eq(400)
  # end

  it 'ignores any additional attributes sent by the user' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id
    previous_name = Item.last.name
    item_params = { name: 'Hawaiian Shirt', model_number: '28P1817074' }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful

    item = Item.find(id)
    expect(item.name).to eq(item_params[:name])
    expect(item.name).not_to eq(previous_name)
    expect(item).not_to have_attribute(:model_number)

    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes].keys).to match_array(%i[name description unit_price merchant_id])
  end
end
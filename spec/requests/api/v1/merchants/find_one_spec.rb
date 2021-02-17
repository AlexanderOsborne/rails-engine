require 'rails_helper'

RSpec.describe 'merchant search' do
  it 'returns a single merchant' do
    create(:merchant, name: "Taco's y Salsas")

    get "/api/v1/merchants/find?name=taco"
    
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a(Hash)
    expect(merchant[:data].keys).to match_array(%i[id type attributes])
    expect(merchant[:data][:attributes].keys).to match_array(%i[name])
  end

  it 'returns an empty hash if no merchant is not found' do
    create(:merchant)

    get "/api/v1/merchants/find?name=NOMATCH"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant).to be_a(Hash)
    expect(merchant[:data]).to be_empty
  end

  it 'returns an empty hash if no query string is provided' do
    get "/api/v1/merchants/find"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a(Hash)
    expect(merchant[:data]).to be_empty
  end
end
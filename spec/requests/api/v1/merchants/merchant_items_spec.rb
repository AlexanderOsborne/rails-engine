require 'rails_helper'
RSpec.describe 'Merchants', type: :request do
  
  describe 'Returns items associated with a merchant' do
    it 'succeeds when there is something to fetch' do
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      create_list(:item, 12, merchant: merchant)
      create_list(:item, 12, merchant: merchant2)

      get api_v1_merchant_items_path(merchant.id)
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][0][:attributes][:merchant_id]).to eq(merchant.id)
      expect(json[:data].size).to eq(12)
    end

    it 'fails with 400 if merchant does not exist' do
      get api_v1_merchant_path(999999)
      
      expect(response.status).to eq(404)
    end
  end
end
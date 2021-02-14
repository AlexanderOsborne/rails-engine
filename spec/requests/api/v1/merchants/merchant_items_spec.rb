require 'rails_helper'
RSpec.describe 'Merchants', type: :request do
  
  describe 'Returns items associated with a merchant' do
    it 'succeeds when there is something to fetch' do
      merchant = create(:merchant)
      create_list(:item, 12, merchant: merchant)

      get api_v1_merchant_items_path(merchant.id)
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:id]).to eq(merchant.id.to_s)

      expected_attributes.each do |attribute, value|
        expect(json[:data][:attributes][attribute]).to eq(value)
      end
    end

    it 'fails with 404 if merchant does not exist' do
      get api_v1_merchant_path(999999)
      
      expect(response.status).to eq(404)
    end
  end
end
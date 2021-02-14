require 'rails_helper'
RSpec.describe 'Items', type: :request do
  describe 'fetching a single item' do
    it 'succeeds when there is something to fetch' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get api_v1_item_path(item.id)
      expect(response.status).to eq(200)
      # require 'pry'; binding.pry
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:id]).to eq(item.id.to_s)
    end

    it 'fails with 404 if merchant does not exist' do
      get api_v1_merchant_path(999999)
      
      expect(response.status).to eq(404)
    end
  end
end
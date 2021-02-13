require 'rails_helper'
RSpec.describe 'Merchants', type: :request do

  it 'it sends a list of 20 merchants' do
    create_list(:merchant, 25)

  get '/api/v1/merchants?page=1'
  expect(response).to be_successful
  
  page1 = JSON.parse(response.body, symbolize_names: true)

  get 'api/v1/merchants?page=2'
  page2 = JSON.parse(response.body, symbolize_names: true)

  expect(page1[:data].size).to eq(20)
  expect(page1[:data].size).to eq(5)
  # expect(page1[:data.pluck(:id)).not.to include(page2[:data.pluck(:id))
  end
end
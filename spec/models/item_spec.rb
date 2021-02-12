require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
    it { should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
  end

  describe 'instance methods' do
  end
end
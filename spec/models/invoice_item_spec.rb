require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :items_id}
    it { should validate_presence_of :invoices_id}
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :unit_price}
  end

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'instance methods' do
  end
end

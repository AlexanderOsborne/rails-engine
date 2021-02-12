class Item < ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true
  validates_presence_of :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items
end

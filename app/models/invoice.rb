class Invoice < ApplicationRecord
  validates_presence_of :customer_id, presence: true
  validates_presence_of :merchant_id, presence: true
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  # enum status: [:pending, :packaged, :shipped, :returned]
end

class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, presence: true
  validates_presence_of :credit_card_number, presence: true
  validates_presence_of :credit_card_expiration_date, presence: true
  belongs_to :invoice
  enum status: [:success, :failed, :refunded]
end

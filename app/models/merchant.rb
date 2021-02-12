class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true
  has_many :items
  has_many :invoices
end

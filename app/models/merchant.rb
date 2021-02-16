class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true
  has_many :items, dependent: :destroy
  has_many :invoices

  def self.find_one(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%").order(:name).first
  end
end

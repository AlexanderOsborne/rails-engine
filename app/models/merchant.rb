class Merchant < ApplicationRecord
  validates_presence_of :name, presence: true
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :items

  def self.top_revenue(limit)
    joins(invoices: %i[invoice_items transactions])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where('invoices.status = ? AND transactions.result = ?', "shipped", "success")
    .order('revenue desc')
    .limit(limit||10)
    .group(:id)
  end

  # def self.unshipped_revenue(limit)
  #   joins(invoices: %i[invoice_items transactions])
  #   .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue')
  #   .where('invoices.status <> ? AND transactions.result = ?', "shipped", "success")
  #   .order('potential_revenue desc')
  #   .limit(limit||10)
  #   .group(:id)
  # end
end

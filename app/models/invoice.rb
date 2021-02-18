class Invoice < ApplicationRecord
  validates_presence_of :customer_id, presence: true
  validates_presence_of :merchant_id, presence: true
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  # enum status: [:pending, :packaged, :shipped, :returned]

  def self.unshipped_invoice_revenue(limit)
      joins(%i[invoice_items transactions])
      .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue')
      .where('invoices.status <> ? AND transactions.result = ?', "shipped", "success")
      .order('potential_revenue desc')
      .limit(limit||10)
      .group(:id)
    end
end

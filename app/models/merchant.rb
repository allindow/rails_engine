class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(number)
    select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items)
    .order("revenue DESC")
    .group("merchants.id")
    .take(number)
  end

  def pending_customers
    customers.find(self.
    invoices.includes(:transactions)
    .references(:transactions)
    .where.not(transactions: { result: "success" })
    .pluck(:customer_id))
  end
end

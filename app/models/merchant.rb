class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(number)
    select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items)
    .order("revenue DESC")
    .group("merchants.id")
    .take(number)
  end
end

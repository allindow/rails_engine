class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.most_items(number)
    select("items.*, SUM(invoice_items.quantity) AS most_items")
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .order("most_items DESC")
    .group("items.id")
    .take(number)
  end

  def self.most_revenue(quantity)
    select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .order("revenue DESC")
    .group("items.id").take(quantity)
  end
end

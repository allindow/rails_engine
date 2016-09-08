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

  # def self.best_day(date)
  #   Item.select("items.*, SUM(invoice_items.quantity) AS most_items")
  #   .joins(:transactions, :invoice_items)
  #   .merge(Transaction.success)
  #   .where(transactions: {created_at: date})
  #   .order("most_items DESC")
  #   .group("items.id")
  # end
end

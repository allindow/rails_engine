class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(number)
    select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items)
    .order("revenue DESC")
    .group("merchants.id")
    .take(number)
  end

  def pending_customers
    customers.joins(:invoices)
    .joins("INNER JOIN transactions ON transactions.invoice_id=invoices.id")
    .merge(Transaction.failed)
    .distinct
  end

  def self.revenue(merchant_id)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .where("merchants.id = #{merchant_id}")
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_date(merchant_id, date)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .where("merchants.id = #{merchant_id}").where(invoices: {created_at: date})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.total_revenue_by_date(date)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .where(invoices: {created_at: date})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def favorite_customer
    customers.joins(:transactions).merge(Transaction.success)
    .select("customers.*, (transactions.count) as SALES")
    .group('customers.id').order('sales DESC').first
  end

  def self.most_items(number)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.success)
    .group("merchants.id")
    .order("sum(invoice_items.quantity) DESC").take(number)
  end
end

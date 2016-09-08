class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.joins(:transactions)
    .merge(Transaction.success)
    .select("merchants.*, (transactions.count) as SALES")
    .group("merchants.id")
    .order('SALES DESC')
    .first
  end
end

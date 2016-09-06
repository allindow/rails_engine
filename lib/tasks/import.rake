require 'csv'

desc "Import customers from csv files"
task :import => [:environment] do

  customers     = "data/customers.csv"
  invoice_items = "data/invoice_items.csv"
  invoices      = "data/invoices.csv"
  items         = "data/items.csv"
  merchants     = "data/merchants.csv"
  transactions  = "data/transactions.csv"

  CSV.foreach(customers, headers: true) do |row|
    Customer.create!(row.to_hash)
  end

  CSV.foreach(merchants, headers: true) do |row|
    Merchant.create!(row.to_hash)
  end

  CSV.foreach(items, headers: true) do |row|
    Item.create!(row.to_hash)
  end

  CSV.foreach(invoices, headers: true) do |row|
    Invoice.create!(row.to_hash)
  end

  CSV.foreach(transactions, headers: true) do |row|
    Transaction.create!(row.to_hash)
  end

  CSV.foreach(invoice_items, headers: true) do |row|
    InvoiceItem.create!(row.to_hash)
  end

end

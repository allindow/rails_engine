require 'csv'

desc "Import customers from csv files"
task :import => [:environment] do

  customers     = "data/customers.csv"
  invoice_items = "data/invoice_items.csv"
  invoices      = "data/invoices.csv"
  items         = "data/items.csv"
  merchants     = "data/merchants.csv"
  transactions  = "data/transactions.csv"

  def cents_to_dollars(input)
    input.insert(-3, ".")
  end

  CSV.foreach(customers, headers: true) do |row|
    customer = Customer.create!(row.to_hash)
    puts "Created Customer #{customer.id}"
  end

  CSV.foreach(merchants, headers: true) do |row|
    merchant = Merchant.create!(row.to_hash)
    puts "Created Merchant #{merchant.id}"
  end

  CSV.foreach(items, headers: true) do |row|
    item = Item.create!(id: row["id"],
      name: row["name"],
      description: row["description"],
      unit_price: cents_to_dollars(row["unit_price"]),
      merchant_id: row["merchant_id"],
      created_at: row["created_at"],
      updated_at: row["updated_at"])
    puts "Created Item #{item.id}"
  end

  CSV.foreach(invoices, headers: true) do |row|
    invoice = Invoice.create!(row.to_hash)
    puts "Created Invoice #{invoice.id}"
  end

  CSV.foreach(transactions, headers: true) do |row|
    cct = Transaction.create!(invoice_id: row["invoice_id"],
    credit_card_number: row["credit_card_number"],
    result: row["result"],
    created_at: row["created_at"],
    updated_at: row["updated_at"]
    )
    puts "Created Transaction #{cct.id}"
  end

  CSV.foreach(invoice_items, headers: true) do |row|
    ii = InvoiceItem.create!(item_id: row["item_id"],
      invoice_id: row["invoice_id"],
      quantity: row["quantity"],
      unit_price: cents_to_dollars(row["unit_price"]),
      created_at: row["created_at"],
      updated_at: row["updated_at"])
    puts "Created Invoice Item #{ii.id}"
  end

end

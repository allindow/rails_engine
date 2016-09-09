require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_db_column "name" }
  it { should have_many(:items) }
  it { should have_many(:invoices) }

  it "can get merchants with most revenue" do
    create_list(:invoice_item, 4)

    result = Merchant.select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items)
    .order("revenue DESC")
    .group("merchants.id")
    .take(2)

    expect(Merchant.most_revenue(2)).to eq(result)
  end

  it "can get total revenue for a merchant" do
    invoice_item = create(:invoice_item, unit_price: 1, quantity: 1)
    invoice = invoice_item.invoice
    transaction = create(:transaction, invoice: invoice)
    merchant = invoice.merchant

    expect(1).to eq(Merchant.revenue(merchant.id))
  end

  it "can return the merchant that has sold the most items" do
    merchant_one, merchant_two = create_list(:merchant, 2)
    customer      = create(:customer)
    invoice_one   = create(:invoice, customer: customer, merchant: merchant_one)
    invoice_two   = create(:invoice, customer: customer, merchant: merchant_one)
    invoice_three = create(:invoice, customer: customer, merchant: merchant_one)

    invoice_one.transactions    << create(:transaction)
    invoice_two.transactions    << create(:transaction)
    invoice_three.transactions  << create(:transaction)
    invoice_one.invoice_items   << create(:invoice_item)
    invoice_two.invoice_items   << create(:invoice_item)
    invoice_three.invoice_items << create(:invoice_item)

    merchant = Merchant.most_items(1).first

    expect(merchant).to eq(merchant_one)
  end

  it "can get pending customers for merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id)
    create(:transaction, invoice_id: invoice.id)
    create(:transaction, invoice_id: invoice.id, result: "failed")

    result = merchant.customers.find(merchant.invoices
              .includes(:transactions).references(:transactions)
              .where.not(transactions: { result: "success" })
              .pluck(:customer_id))

    expect(merchant.pending_customers).to eq(result)
  end

  it "can get favorite customer for a merchant" do
    merchant = create(:merchant)
    cust1 = create(:customer)
    cust2 = create(:customer)
    inv1 = create(:invoice, customer_id: cust1.id, merchant_id: merchant.id)
    inv2 = create(:invoice, customer_id: cust2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv2.id)

    expect(merchant.favorite_customer).to eq(cust1)
  end

  it "can return the revenue for a merchant on a date" do
    merch = create(:merchant)
    invoice = create(:invoice, merchant: merch, created_at: "2016-03-20 23:57:05 UTC" )
    item = create(:item, merchant: merch, unit_price: 500)
    create(:invoice_item, quantity: 2, invoice: invoice, item: item, unit_price: 500)
    create(:transaction, invoice: invoice)

    expect(Merchant.revenue_date(merch.id, "2016-03-20 23:57:05 UTC")).to eq(1000)
  end

  it "can return the total revenue for a date" do
    merch = create(:merchant)
    invoice = create(:invoice, merchant: merch, created_at: "2016-03-20 23:57:05 UTC" )
    item = create(:item, merchant: merch, unit_price: 500)
    create(:invoice_item, quantity: 2, invoice: invoice, item: item, unit_price: 500)
    create(:transaction, invoice: invoice)

    expect(Merchant.total_revenue_by_date("2016-03-20 23:57:05 UTC")).to eq(1000)
  end
end

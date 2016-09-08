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
end

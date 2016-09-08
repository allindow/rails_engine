require 'rails_helper'

RSpec.describe "Merchant Requests", type: :request do
  after(:each) do
    expect(response).to be_success
  end

  it "should get all merchants" do
    create_list(:merchant, 2)

    get '/api/v1/merchants'

    expect(json.count).to eq(2)
  end

  it "should get one merchants" do
    create(:merchant, id: 1)

    get '/api/v1/merchants/1'

    expect(json.count).to eq(4)
  end

  it "should get the favorite customer" do
    merchant = create(:merchant)
    cust1 = create(:customer)
    cust2 = create(:customer)
    inv1 = create(:invoice, customer_id: cust1.id, merchant_id: merchant.id)
    inv2 = create(:invoice, customer_id: cust2.id, merchant_id: merchant.id)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv2.id)

    expect(merchant.favorite_customer).to eq(cust1)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(json["first_name"]).to eq(cust1.first_name)
  end

  it "should get a customer with a pending invoice" do
    merch = create(:merchant)
    customer = create(:customer)
    invoice = Invoice.create!(customer_id: customer.id, merchant_id: merch.id, status: "shipped")
    transaction = Transaction.create!(credit_card_number: "0000", result: "failed", invoice_id: invoice.id)

    get "/api/v1/merchants/#{merch.id}/customers_with_pending_invoices"

    expect(json.first["first_name"]).to eq(customer.first_name)
    expect(json.first["last_name"]).to eq(customer.last_name)
  end

  it "should find invoices for a merchant" do
    merch1, merch2 = create_list(:merchant, 2)
    create(:invoice, merchant: merch1)

    get "/api/v1/merchants/#{merch1.id}/invoices"

    expect(json.count).to eq(1)
  end

  it "should find items for a merchant" do
    merch1, merch2 = create_list(:merchant, 2)
    create(:item, merchant: merch1)

    get "/api/v1/merchants/#{merch1.id}/items"

    expect(json.count).to eq(1)
  end

  it "can get a random merchant" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/random"
    expect(response.status).to eq(200)
    expect(json.count).to eq(4)
    expect(Merchant.pluck(:id)).to include(json['id'])
  end

  it "can get the revnue for merchant" do
    create(:invoice_item)
    ii = create(:invoice_item, unit_price: 100, quantity: 2)
    invoice = ii.invoice
    transaction = create(:transaction, invoice: invoice)
    merchant = invoice.merchant
    expected = {"revenue"=>"200.0"}

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(expected).to eq(json)
  end

  it "can get the revnue for merchant" do
    create(:invoice_item)
    ii = create(:invoice_item, unit_price: 100, quantity: 2)
    invoice = ii.invoice
    transaction = create(:transaction, invoice: invoice)
    merchant = invoice.merchant
    expected = {"revenue"=>"0.0"}

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{Time.now}"

    expect(expected).to eq(json)
  end

  it "can get the revenue for all merchants" do
    create(:invoice_item)
    ii = create(:invoice_item, unit_price: 100, quantity: 2)
    invoice = ii.invoice
    transaction = create(:transaction, invoice: invoice)
    merchant = invoice.merchant
    expected = {"total_revenue"=>"0.0"}

    get "/api/v1/merchants/revenue?date=#{Time.now}"

    expect(expected).to eq(json)
  end

  it "finds merchants" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/find_all"

    expect(json.count).to eq(3)
  end

  it "finds an individual merchant" do
    merchant = create_list(:merchant, 3)

    get "/api/v1/merchants/find"

    expect(json.count).to eq(4)
  end

  it "returns top merchants by revenue" do
    merchant1, merchant2 = create_list(:merchant, 2)

    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: "success")
    invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 500, unit_price: 1000)

    transaction2 = create(:transaction, invoice: invoice2, result: "success")
    invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 2, unit_price: 5)

    get '/api/v1/merchants/most_revenue', params: {quantity: 1}

    expect(json.count).to eq(1)
    expect(json[0]["name"]).to eq(merchant1.name)
  end

  it "returns merchant with most items" do
    merchant1, merchant2 = create_list(:merchant, 2)

    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)

    transaction1 = create(:transaction, invoice: invoice1, result: "success")
    invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 500, unit_price: 1000)

    transaction2 = create(:transaction, invoice: invoice2, result: "success")
    invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 2, unit_price: 5)

    get '/api/v1/merchants/most_items', params: {quantity: 1}

    expect(json.count).to eq(1)
    expect(json[0]["name"]).to eq(merchant1.name)
  end
end

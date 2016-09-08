require 'rails_helper'

RSpec.describe "Merchant Requests", type: :request do
  it "should get all merchants" do
    create_list(:merchant, 2)

    get '/api/v1/merchants'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq(2)
  end

  it "should get one merchants" do
    create(:merchant, id: 1)

    get '/api/v1/merchants/1'

    json = JSON.parse(response.body)

    expect(response).to be_success
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

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["first_name"]).to eq(cust1.first_name)
  end

  it "should get a customer with a pending invoice" do
    merch = create(:merchant)
    customer = create(:customer)
    invoice = Invoice.create!(customer_id: customer.id, merchant_id: merch.id, status: "shipped")
    transaction = Transaction.create!(credit_card_number: "0000", result: "failed", invoice_id: invoice.id)

    get "/api/v1/merchants/#{merch.id}/customers_with_pending_invoices"

    expect(response.status).to eq(200)

    json = JSON.parse(response.body)

    expect(json.first["first_name"]).to eq(customer.first_name)
    expect(json.first["last_name"]).to eq(customer.last_name)
  end

  it "should find invoices for a merchant" do
    merch1, merch2 = create_list(:merchant, 2)
    create(:invoice, merchant: merch1)

    get "/api/v1/merchants/#{merch1.id}/invoices"

    expect(response.status).to eq(200)

    json = JSON.parse(response.body)

    expect(json.count).to eq(1)
  end

  it "should find items for a merchant" do
    merch1, merch2 = create_list(:merchant, 2)
    create(:item, merchant: merch1)

    get "/api/v1/merchants/#{merch1.id}/items"

    expect(response.status).to eq(200)

    json = JSON.parse(response.body)

    expect(json.count).to eq(1)
  end
end

require 'rails_helper'

RSpec.describe "Invoice", type: :request do
  after(:each) do
    expect(response).to be_success
  end

  it "it gets all invoices" do
    invoice_one, invoice_two, invoice_three = create_list(:invoice, 3)

    get "/api/v1/invoices"

    expect(json.count).to eq(3)
    expect(invoice_one.customer_id).to eq(json.first["customer_id"])
    expect(invoice_one.id).to eq(json.first["id"])
  end

  it "gets a specific record" do
    invoice_one, invoice_two, invoice_three = create_list(:invoice, 3)

    get "/api/v1/invoices/#{invoice_two.id}"

    expect(invoice_two.id).to eq(json["id"])
    expect(invoice_two.customer_id).to eq(json["customer_id"])
    expect(invoice_two.merchant_id).to eq(json["merchant_id"])
  end

  it "should find an invoice's transactions" do
    invoice = create(:invoice)
    transaction1, transaction2 = create_list(:transaction, 2, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(json[0]["id"]).to eq(transaction1.id)
  end

  it 'gets a single invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    expect(json["id"]).to eq(invoice.id)
    expect(json["status"]).to eq(invoice.status)
  end

  it 'gets all the invoices when find_all' do
    invoices = create_list(:invoice, 3)
    invoices[0].status = "shipped"
    invoices[1].status = "shipped"
    invoices[2].status = "not yet shipped"

    get "/api/v1/invoices/find_all?status=shipped"

    expect(json[0]["id"]).to eq(invoices[0].id)
    expect(json[1]["id"]).to eq(invoices[1].id)
    expect(json[0]["status"]).to eq(invoices[0].status)
  end

  it "should return an invoice's merchant" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(json["id"]).to eq(invoice.merchant_id)
  end

  it "should return an invoice's item" do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item1 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 5)
    invoice_item2 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 4)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(json.count).to eq(2)
  end

  it "should return an invoice's invoice items" do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item1 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 5)
    invoice_item2 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 4)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(json.count).to eq(2)
  end

  it "should return an invoice's customer" do
    invoice1, invoice2 = create_list(:invoice, 2)

    get "/api/v1/invoices/#{invoice1.id}/customer"

    expect(json["id"]).to eq(invoice1.customer_id)
  end

  it "should get a random invoice" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/random"

    expect(json.count).to eq(6)
    expect(Invoice.pluck(:id)).to include(json['id'])
  end
end

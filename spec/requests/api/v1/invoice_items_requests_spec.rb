require 'rails_helper'

RSpec.describe "Invoice Item", type: :request do
  after(:each) do
    expect(response).to be_success
  end

  it "it can find invoice items" do
    invoice_item_one, invoice_item_two = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items"

    expect(json.count).to eq(2)
    expect(invoice_item_one.quantity).to eq(json.first["quantity"])
    expect(invoice_item_one.id).to eq(json.first["id"])
    expect(invoice_item_two.id).to eq(json.last["id"])

    get "/api/v1/invoice_items/#{invoice_item_one.id}"

    expect(invoice_item_one.id).to eq(json["id"])
    expect(invoice_item_one.quantity).to eq(json["quantity"])
  end

  it 'can find a single item' do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1000, quantity: 5)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(json["id"]).to eq(invoice_item.id)
    expect(json["quantity"]).to eq(invoice_item.quantity)
    expect(json["unit_price"]).to eq(((invoice_item.unit_price).to_f).to_s)
  end

  it 'sends multiple records when given a find all search' do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item1 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 5)
    invoice_item2 = InvoiceItem.create(invoice_id: invoice.id, item_id: item.id, unit_price: 1, quantity: 4)

    get "/api/v1/invoice_items/find_all?quantity=4"

    expect(json.count).to eq(1)
  end

  it "can return the items for an invoice item" do
    ii1, ii2 = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/#{ii2.id}/item"

    expect(json["id"]).to eq(ii2.item_id)
    expect(json["id"]).to_not eq(ii1.item_id)
  end

  it "can return the invoices for invoice items" do
    invoice_item1, invoice_item2 = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

    expect(json["id"]).to eq(invoice_item1.invoice_id)
  end

  it "should get a random invoice item" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random"

    expect(json.count).to eq(7)
    expect(InvoiceItem.pluck(:id)).to include(json['id'])
  end
end

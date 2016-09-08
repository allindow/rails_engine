require 'rails_helper'

RSpec.describe "Invoice Requests", type: :request do
  it "it finds all items" do
    item_one, item_two = create_list(:item, 2)

    get "/api/v1/items"

    expect(response.status).to eq(200)
    expect(json.count).to eq(2)
    expect(item_one.name).to eq(json.first["name"])
    expect(item_one.id).to eq(json.first["id"])
    expect(item_two.name).to eq(json.last["name"])
    expect(item_two.id).to eq(json.last["id"])
  end

  it "can return a single record" do
    item_one, item_two = create_list(:item, 2)

    get "/api/v1/items/#{item_two.id}"

    expect(response.status).to eq(200)
    expect(item_two.id).to eq(json["id"])
    expect(item_two.name).to eq(json["name"])
  end

  it 'finds a single record with find' do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response.status).to eq(200)
    expect(json["id"]).to eq(item.id)
    expect(json["description"]).to eq(item.description)
    expect(json["name"]).to eq(item.name)
    expect(json["unit_price"]).to eq((item.unit_price.to_f).to_s)
  end

  it 'sends multiple records when given a find all search' do
    items = create_list(:item, 2, name: "angela")

    get "/api/v1/items/find_all?name=angela"

    expect(response.status).to eq(200)
    expect(json.count).to eq(2)
    expect(json[0]["description"]).to eq(items[0].description)
    expect(json[1]["unit_price"]).to eq((items[1].unit_price.to_f).to_s)
  end

  it "can find the most popular item" do
    customer = create(:customer)
    item_one = create(:item)
    item_two = create(:item)
    invoice_one = create(:invoice, customer: customer)
    invoice_two = create(:invoice, customer: customer)
    invoice_three = create(:invoice, customer: customer)
    invoice_one.transactions    << create(:transaction)
    invoice_two.transactions    << create(:transaction)
    invoice_three.transactions  << create(:transaction)
    invoice_one.invoice_items   << create(:invoice_item, item: item_two)
    invoice_two.invoice_items   << create(:invoice_item, item: item_two)
    invoice_three.invoice_items << create(:invoice_item, item: item_two)

    get "/api/v1/items/most_items?quantity=1"

    item = Item.most_items(1).first
    expect(response.status).to eq(200)
    expect(json[0]["id"]).to eq(item_two.id)
  end

  it "finds the best day for an item" do
    item = create(:item)
    invoice = create(:invoice, merchant_id: item.merchant_id)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    transaction = create(:transaction, invoice: invoice, result: "success")

    get "/api/v1/items/#{item.id}/best_day"

    expect(response.status).to eq(200)
    expect(json.count).to eq(1)
  end

  it "can return an items' merchant" do
    merch = create(:merchant)
    item = create(:item, merchant_id: merch.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response.status).to eq(200)
    expect(json["id"]).to eq(item.merchant_id)
  end

  it "can return invoice items for an item" do
    item1 = create(:item)
    invoice_item1, invoice_item2 = create_list(:invoice_item, 2, item_id: item1.id)

    get "/api/v1/items/#{item1.id}/invoice_items"

    expect(response.status).to eq(200)
    expect(json[0]["id"]).to eq(invoice_item1.id)
  end

  it "should get a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random"

    expect(response).to be_success

    expect(json.count).to eq(7)
    expect(Item.pluck(:id)).to include(json['id'])
  end
end

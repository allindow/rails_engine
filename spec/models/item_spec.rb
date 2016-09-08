require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_db_column "name" }
  it { should have_db_column "description" }
  it { should have_db_column "unit_price" }
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  it "should return x items with the most revenue" do
    item1 = create(:item)
    item2 = create(:item)
    inv1 = create(:invoice)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv1.id)
    create(:invoice_item, invoice_id: inv1.id, item_id: item1.id, quantity: 1, unit_price: 10)
    create(:invoice_item, invoice_id: inv1.id, item_id: item2.id, quantity: 1, unit_price: 5)

    expect(Item.most_revenue(1)).to eq([item1])
  end

  it "should return best day" do
    item2 = create(:item)
    inv1 = create(:invoice)
    create(:transaction, invoice_id: inv1.id)
    create(:invoice_item, invoice_id: inv1.id, item_id: item2.id, quantity: 1, unit_price: 5)

    expect(item2.best_day).to eq(inv1.created_at)
  end

  it "should return the most sold item" do
    item1 = create(:item)
    item2 = create(:item)
    inv1 = create(:invoice)
    inv2 = create(:invoice)
    inv3 = create(:invoice)
    create(:transaction, invoice_id: inv1.id)
    create(:transaction, invoice_id: inv1.id)
    create(:invoice_item, invoice_id: inv1.id, item_id: item1.id, quantity: 1, unit_price: 10)
    create(:invoice_item, invoice_id: inv1.id, item_id: item2.id, quantity: 1, unit_price: 5)
    inv1.transactions << create(:transaction)
    inv2.transactions << create(:transaction)
    inv3.transactions << create(:transaction)
    inv1.invoice_items << create(:invoice_item, item: item1)
    inv2.invoice_items << create(:invoice_item, item: item1)
    inv3.invoice_items << create(:invoice_item, item: item2)

    item = Item.most_items(1).first

    expect(item.id).to eq(item1.id)
  end
end

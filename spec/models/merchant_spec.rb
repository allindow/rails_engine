require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_db_column "name" }
  it { should have_many(:items) }
  it { should have_many(:invoices) }

  it "can get merchants with most revenue" do
    4.times do
      create(:invoice_item)
    end

    result = Merchant.select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items)
    .order("revenue DESC")
    .group("merchants.id")
    .take(2)
    
    expect(Merchant.most_revenue(2)).to eq(result)
  end
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_db_column "first_name" }
  it { should have_db_column "last_name" }
  it { should have_many(:invoices) }

  it "can find it's favorite merchant" do
      customer = create(:customer)
      merchant1, merchant2 = create_list(:merchant, 2)
      invoice = create(:invoice, merchant: merchant1, customer: customer)
      invoices_two = create_list(:invoice, 2, merchant: merchant2, customer: customer)
      create(:transaction, invoice: invoice)
      create(:transaction, invoice: invoices_two.first)
      create(:transaction, invoice: invoices_two.last)

      expect(customer.favorite_merchant).to eq(merchant2)
    end
end

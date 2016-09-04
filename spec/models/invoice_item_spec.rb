require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should have_db_column "quantity" }
  it { should have_db_column "unit_price" }
  it { should belong_to(:invoice) }
  it { should belong_to(:item) }
end

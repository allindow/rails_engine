require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_db_column "name" }
  it { should have_db_column "description" }
  it { should have_db_column "unit_price" }
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }  
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_db_column "first_name" }
  it { should have_db_column "last_name" }
  it { should have_many(:invoices) }
end

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should have_db_column "credit_card_number" }
  it { should have_db_column "credit_card_expiration_date" }
  it { should have_db_column "result" }
  it { should belong_to(:invoice) }
end

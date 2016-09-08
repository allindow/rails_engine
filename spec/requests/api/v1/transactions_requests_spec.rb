require 'rails_helper'

RSpec.describe "Transactions requests", type: :request do
  after(:each) do
    expect(response).to be_success
  end

  it "should get all transactions" do
    create_list(:transaction, 2)

    get '/api/v1/transactions'

    expect(json.count).to eq(2)
  end

  it "should get a single customer by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(json['id']).to eq(transaction.id)
    expect(json['result']).to eq(transaction.result)
  end

  it "should get the invoice for a certain transaction" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(json['id']).to eq(transaction.invoice.id)
  end

  it "should get a random transaction" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/random"

    expect(json.count).to eq(6)
  end

  it "should get all transactions by certain parameter" do
    2.times { create(:transaction, result: "failed") }
    failed = Transaction.take(2)
    create(:transaction)

    get "/api/v1/transactions/find_all?result=failed"

    expect(json.count).to eq(2)
    expect([failed.first.id, failed.last.id]).to include(json.first['id'])
    expect([failed.first.id, failed.last.id]).to include(json.last['id'])
  end

  it "should get a single transaction by certain parameter" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    expect(json.count).to eq(6)
    expect(json['id']).to eq(transaction.id)
    expect(json['invoice_id']).to eq(transaction.invoice_id)
  end

end

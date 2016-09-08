require 'rails_helper'

RSpec.describe "Customers requests", type: :request do
  it "should get all customers" do
    create_list(:customer, 2)

    get '/api/v1/customers'

    expect(response).to be_success
    expect(json.count).to eq(2)
  end

  it "should get a single customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_success
    expect(json['id']).to eq(customer.id)
    expect(json['first_name']).to eq(customer.first_name)
  end

  it "should get invoices for specific customer" do
    customer = create(:customer)
    2.times { create(:invoice, customer: customer) }

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success
    expect(json.count).to eq(2)
  end

  it "should get a random customer" do
    create_list(:customer, 3)

    get "/api/v1/customers/random"

    expect(response).to be_success
    ##expect the count to be 5 because a customer has 5
    # attributes and this is not an array
    expect(json.count).to eq(5)
    expect(Customer.pluck(:id)).to include(json['id'])
  end

  it "should find all customers that match certain params" do
    2.times { create(:customer, first_name:"Beth") }

    get "/api/v1/customers/find_all?first_name=Beth"
    expect(response).to be_success
    expect(json.count).to eq(2)
  end

  it "should find a single customer by a param" do
    create(:customer, first_name:"Beth")
    create(:customer)

    get "/api/v1/customers/find?first_name=Beth"
    expect(response).to be_success
    expect(json.count).to eq(5)
  end

  it "should find all transactions for a certain customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    2.times { create(:transaction, invoice: invoice) }

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success
    expect(json.count).to eq(2)
  end

end

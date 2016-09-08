require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :request do
  it "should get all customers" do
    create_list(:item, 2)

    get '/api/v1/items'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq(2)
  end


end

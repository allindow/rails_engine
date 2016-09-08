# require 'rails_helper'
#
# RSpec.describe Api::V1::CustomersController, type: :request do
#   it "should get all customers" do
#     create_list(:item, 2)
#
#     get '/api/v1/items'
#
#     expect(response).to be_success
#     expect(json.count).to eq(2)
#   end
#
#   it "should get a single customer by id" do
#     item = create(:item)
#
#     get "/api/v1/items/#{item.id}"
#
#     expect(response).to be_success
#     expect(json['id']).to eq(item.id)
#     expect(json['name']).to eq(item.name)
#   end
# end

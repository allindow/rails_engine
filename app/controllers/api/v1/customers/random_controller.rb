class Api::V1::Customers::RandomController < Api::V1::BaseController
  def show
    customer = Customer.random

    respond_with customer
  end
end

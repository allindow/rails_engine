class Api::V1::Customers::RandomController < Api::V1::BaseController
  def show
    @customer = Customer.random
    render 'api/v1/customers/show'
  end
end

class Api::V1::CustomersController < Api::V1::BaseController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(parms[:id])
  end
end

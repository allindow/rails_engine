class Api::V1::Customers::SearchController < Api::V1::BaseController
  def index
    @customers = Customer.where(query_params)
    render 'api/v1/customers/index'
  end

  def show
    @customer = Customer.find_by(query_params)
    render 'api/v1/customers/show'
  end
end

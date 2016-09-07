class Api::V1::Customers::SearchController < Api::V1::BaseController
  def index
    @customers = Customer.where(query_params)
  end

  def show
    @customer = Customer.find_by(query_params)
  end
end

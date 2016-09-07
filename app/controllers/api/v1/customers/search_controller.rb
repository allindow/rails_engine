class Api::V1::Customers::SearchController < Api::V1::BaseController
  def index
    customers = Customers.where(query_params)

    respond_with customers
  end

  def show
    customer = Customers.find_by(query_params)

    respond_with customer
  end
end

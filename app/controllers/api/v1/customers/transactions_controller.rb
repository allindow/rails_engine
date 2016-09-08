class Api::V1::Customers::TransactionsController < Api::V1::BaseController
  def index
    @transactions = Customer.find(params[:id]).transactions
    render 'api/v1/transactions/index'
  end
end

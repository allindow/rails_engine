class Api::V1::Transactions::SearchController < Api::V1::BaseController
  def index
    @transactions = Transaction.where(query_params)
    render 'api/v1/transactions/index'
  end

  def show
    @transaction = Transaction.find_by(query_params)
    render 'api/v1/transactions/show'
  end
end

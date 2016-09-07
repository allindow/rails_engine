class Api::V1::Transactions::SearchController < Api::V1::BaseController
  def index
    transactions = Transaction.where(query_params)

    respond_with transactions
  end

  def show
    transaction = Transaction.find_by(query_params)

    respond_with transaction
  end
end

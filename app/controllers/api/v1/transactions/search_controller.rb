class Api::V1::Transactions::SearchController < Api::V1::BaseController
  def index
    @transactions = Transaction.where(query_params)
  end

  def show
    @transaction = Transaction.find_by(query_params)
  end
end

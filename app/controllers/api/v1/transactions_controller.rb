class Api::V1::TransactionsController < Api::V1::BaseController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end

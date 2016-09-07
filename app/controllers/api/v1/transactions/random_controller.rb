class Api::V1::Transactions::RandomController < Api::V1::BaseController
  def show
    @transaction = Transaction.random
  end
end

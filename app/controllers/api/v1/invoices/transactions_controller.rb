class Api::V1::Invoices::TransactionsController < Api::V1::BaseController

  def index
    transactions = Invoice.find(params[:invoice_id]).transactions

    respond_with transactions
  end
end

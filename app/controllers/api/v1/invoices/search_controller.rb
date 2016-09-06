class Api::V1::Invoices::SearchController < Api::V1::BaseController
  def index
    invoices = Invoice.where(query_params)

    respond_with invoices
  end

  def show
    invoice = Invoice.find_by(query_params)

    respond_with invoice
  end
end

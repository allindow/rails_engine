class Api::V1::Invoices::RandomController < Api::V1::BaseController
  def show
    invoice = Invoice.random

    respond_with invoice
  end
end

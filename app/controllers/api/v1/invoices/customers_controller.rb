class Api::V1::Invoices::CustomersController < Api::V1::BaseController

  def show
    @customer = Invoice.find(params[:invoice_id]).customer
  end
end

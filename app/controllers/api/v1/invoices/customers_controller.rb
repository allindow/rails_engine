class Api::V1::Invoices::CustomersController < Api::V1::BaseController

  def show
    @customer = Invoice.find(params[:invoice_id]).customer
    render 'api/v1/customers/show'
  end
end

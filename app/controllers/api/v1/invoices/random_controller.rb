class Api::V1::Invoices::RandomController < Api::V1::BaseController
  def show
    @invoice = Invoice.random
    render 'api/v1/invoices/show'
  end
end

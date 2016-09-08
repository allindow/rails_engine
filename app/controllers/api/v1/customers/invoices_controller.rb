class Api::V1::Customers::InvoicesController < Api::V1::BaseController
  def index
    @invoices = Customer.find(params[:id]).invoices
    render 'api/v1/invoices/index'
  end
end

class Api::V1::Invoices::SearchController < Api::V1::BaseController
  def index
    @invoices = Invoice.where(query_params)
    render 'api/v1/invoices/index'
  end

  def show
    @invoice = Invoice.find_by(query_params)
    render 'api/v1/invoices/show'
end
end

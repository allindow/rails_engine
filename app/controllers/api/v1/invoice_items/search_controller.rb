class Api::V1::InvoiceItems::SearchController < Api::V1::BaseController
  def index
    @invoice_items = InvoiceItem.where(query_params)
    render 'api/v1/invoice_items/index'
  end

  def show
    @invoice_item = InvoiceItem.find_by(query_params)
    render 'api/v1/invoice_items/show'
  end
end

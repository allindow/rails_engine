class Api::V1::InvoiceItems::SearchController < Api::V1::BaseController
  def index
    @invoice_items = InvoiceItem.where(query_params)
  end

  def show
    @invoice_item = InvoiceItem.find_by(query_params)
  end
end

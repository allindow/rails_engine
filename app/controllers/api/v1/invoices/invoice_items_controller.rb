class Api::V1::Invoices::InvoiceItemsController < Api::V1::BaseController

  def index
    @invoice_items = Invoice.find(params[:invoice_id]).invoice_items
    render 'api/v1/invoice_items/index'
  end
end

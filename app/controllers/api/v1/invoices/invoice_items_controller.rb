class Api::V1::Invoices::InvoiceItemsController < Api::V1::BaseController

  def index
    invoice_items = Invoice.find(params[:invoice_id]).invoice_items

    respond_with invoice_items
  end
end

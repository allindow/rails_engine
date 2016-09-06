class Api::V1::InvoiceItemsController < Api::V1::BaseController

  def index
    invoice_items = InvoiceItem.all

    respond_with invoice_items
  end

  def show
    invoice_item = InvoiceItem.find(params[:id])

    respond_with invoice_item
  end
end

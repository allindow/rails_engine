class Api::V1::InvoiceItemsController < Api::V1::BaseController

  def index
    invoice_items = InvoiceItem.all

    respond_with invoice_items
  end

end

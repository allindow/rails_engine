class Api::V1::InvoiceItemsController < Api::V1::BaseController

  def index
    @invoice_items = InvoiceItem.all
  end

  def show
    @invoice_item = InvoiceItem.find(params[:id])
  end
end

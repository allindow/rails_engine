class Api::V1::Items::InvoiceItemsController < Api::V1::BaseController

  def index
    @invoice_items = Item.find(params[:item_id]).invoice_items
    render 'api/v1/invoice_items/index'
  end
end

class Api::V1::Invoices::ItemsController < Api::V1::BaseController

  def index
    items = Invoice.find(params[:invoice_id]).items

    respond_with items
  end
end

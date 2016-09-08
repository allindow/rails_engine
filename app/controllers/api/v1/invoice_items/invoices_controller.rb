class Api::V1::InvoiceItems::InvoicesController < Api::V1::BaseController

  def show
    @invoice = InvoiceItem.find(params[:invoice_item_id]).invoice
    render 'api/v1/invoices/show'
  end
end

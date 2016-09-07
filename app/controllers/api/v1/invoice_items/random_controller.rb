class Api::V1::InvoiceItems::RandomController < Api::V1::BaseController
  def show
    @invoice_item = InvoiceItem.random
  end
end

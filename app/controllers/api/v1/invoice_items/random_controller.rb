class Api::V1::InvoiceItems::RandomController < Api::V1::BaseController
  def show
    ii = InvoiceItem.random

    respond_with ii
  end
end

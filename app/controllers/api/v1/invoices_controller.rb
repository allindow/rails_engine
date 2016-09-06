class Api::V1::InvoicesController < Api::V1::BaseController

  def index
    invoices = Invoice.all

    respond_with invoices
  end

end

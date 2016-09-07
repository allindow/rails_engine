class Api::V1::InvoicesController < Api::V1::BaseController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end

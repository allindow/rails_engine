class Api::V1::Merchants::InvoicesController < Api::V1::BaseController
  def index
    @invoices = Merchant.find(params[:id]).invoices
    render 'api/v1/invoices/index'
  end
end

class Api::V1::Invoices::MerchantsController < Api::V1::BaseController

  def show
    @merchant = Invoice.find(params[:invoice_id]).merchant
    render 'api/v1/merchants/show'
  end
end

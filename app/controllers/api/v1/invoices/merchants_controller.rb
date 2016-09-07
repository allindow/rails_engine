class Api::V1::Invoices::MerchantsController < Api::V1::BaseController

  def show
    @merchant = Invoice.find(params[:invoice_id]).merchant
  end
end

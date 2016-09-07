class Api::V1::Merchants::PendingCustomersController < Api::V1::BaseController
  def index
    customers = Merchant.find(params[:id]).pending_customers
    respond_with customers
  end
end

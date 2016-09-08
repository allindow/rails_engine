class Api::V1::Merchants::PendingCustomersController < Api::V1::BaseController
  def index
    @customers = Merchant.find(params[:id]).pending_customers
    render 'api/v1/customers/index'
  end
end

class Api::V1::Merchants::MostRevenueController < Api::V1::BaseController
  def index
    @merchants = Merchant.most_revenue(params[:quantity])
    render 'api/v1/merchants/index'
  end
end

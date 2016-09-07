class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  def show
    if params[:date]
      @revenue = Merchant.revenue_date(params[:merchant_id], params[:date])
    else
      @revenue = Merchant.revenue(params[:merchant_id])
    end
  end
end

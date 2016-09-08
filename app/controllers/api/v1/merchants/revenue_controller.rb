class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  def index
    @revenue = Merchant.total_revenue_by_date(params[:date])
    render 'api/v1/merchants/revenue/index'
  end

  def show
    if params[:date]
      @revenue = Merchant.revenue_date(params[:merchant_id], params[:date])
    else
      @revenue = Merchant.revenue(params[:merchant_id])
    end
  end
end

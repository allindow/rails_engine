class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  def index
    @revenue = Merchant.total_revenue_by_date(params[:date])
    render 'api/v1/merchants/revenue/index'
  end

  def show
    @revenue = set_by_param(params)
  end

  private
    def date?(params)
      params.include?(:date)
    end

    def set_by_param(params)
      date?(params) ? Merchant.revenue_date(params[:merchant_id], params[:date]) \
                    : Merchant.revenue(params[:merchant_id])
    end
end

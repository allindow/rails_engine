class Api::V1::Merchants::SearchController < Api::V1::BaseController

  def index
    @merchants = Merchant.where(query_params)
    render 'api/v1/merchants/index'
  end

  def show
    @merchant = Merchant.find_by(query_params)
    render 'api/v1/merchants/show'
  end
end

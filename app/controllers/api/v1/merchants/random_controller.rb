class Api::V1::Merchants::RandomController < Api::V1::BaseController
  def show
    @merchant = Merchant.random
    render 'api/v1/merchants/show'
  end
end

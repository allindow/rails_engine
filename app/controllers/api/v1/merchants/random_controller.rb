class Api::V1::Merchants::RandomController < Api::V1::BaseController

  def show
    @merchant = Merchant.find(rand(1..Merchant.all.count))
  end
end

class Api::V1::Merchants::FavoriteCustomersController < Api::V1::BaseController
  def show
    @customer = Merchant.find(params[:id]).favorite_customer
    render 'api/v1/customers/show'
  end
end

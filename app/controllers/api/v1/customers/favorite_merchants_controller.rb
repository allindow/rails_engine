class Api::V1::Customers::FavoriteMerchantsController < Api::V1::BaseController
  def show
    @merchant = Customer.find(params[:customer_id]).favorite_merchant
    render 'api/v1/merchants/show'
  end
end

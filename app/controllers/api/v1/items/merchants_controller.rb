class Api::V1::Items::MerchantsController < Api::V1::BaseController

  def show
    @merchant = Item.find(params[:item_id]).merchant
    render 'api/v1/merchants/show'
  end
end

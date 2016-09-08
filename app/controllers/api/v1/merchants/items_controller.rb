class Api::V1::Merchants::ItemsController < Api::V1::BaseController
  def index
    @items = Merchant.find(params[:id]).items
    render 'api/v1/items/index'
  end
end

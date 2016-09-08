class Api::V1::Items::RandomController < Api::V1::BaseController
  def show
    @item = Item.random
    render 'api/v1/items/show'
  end
end

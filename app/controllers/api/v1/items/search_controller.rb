class Api::V1::Items::SearchController < Api::V1::BaseController
  def index
    @items = Item.where(query_params)
    render 'api/v1/items/index'
  end

  def show
    @item = Item.find_by(query_params)
    render 'api/v1/items/show'
  end
end

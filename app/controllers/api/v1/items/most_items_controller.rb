class Api::V1::Items::MostItemsController < Api::V1::BaseController
  def index
    @items = Item.most_items(params[:quantity])
    render "api/v1/items/index"
  end
end

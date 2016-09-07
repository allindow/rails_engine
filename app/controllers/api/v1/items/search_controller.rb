class Api::V1::Items::SearchController < Api::V1::BaseController
  def index
    @items = Item.where(query_params)
  end

  def show
    @item = Item.find_by(query_params)
  end
end

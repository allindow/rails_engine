class Api::V1::Items::SearchController < Api::V1::BaseController
  def index
    items = Item.where(query_params)

    respond_with items
  end

  def show
    item = Item.find_by(query_params)

    respond_with item
  end
end

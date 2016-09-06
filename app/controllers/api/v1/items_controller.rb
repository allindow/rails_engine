class Api::V1::ItemsController < Api::V1::BaseController

  def index
    items = Item.all

    respond_with items
  end

end

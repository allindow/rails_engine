class Api::V1::Items::RandomController < Api::V1::BaseController
  def show
    @item = Item.random
  end
end

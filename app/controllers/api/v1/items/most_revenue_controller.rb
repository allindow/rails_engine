class Api::V1::Items::MostRevenueController < Api::V1::BaseController
  def index
    @items = Item.most_revenue(params[:quantity])
    render "api/v1/items/index"
  end
end

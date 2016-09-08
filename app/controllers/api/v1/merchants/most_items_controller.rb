class Api::V1::Merchants::MostItemsController < Api::V1::BaseController
  def index
    @merchants = Merchant.most_items(params[:quantity])
    render "api/v1/merchants/index"
  end
end

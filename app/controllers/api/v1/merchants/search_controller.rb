class Api::V1::Merchants::SearchController < Api::V1::BaseController

  def index
    merchants = Merchant.where(query_params)

    respond_with merchants
  end

  def show
    merchant = Merchant.find_by(query_params)

    respond_with merchant
  end
end

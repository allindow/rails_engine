class Api::V1::MerchantsController < Api::V1::BaseController

  def index
    merchants = Merchant.all

    respond_with merchants
  end

  def show
    merchant = Merchant.find(params[:id])

    respond_with merchant
  end
end

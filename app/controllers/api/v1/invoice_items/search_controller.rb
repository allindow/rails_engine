class Api::V1::InvoiceItems::SearchController < Api::V1::BaseController
  def index
    ii = InvoiceItem.where(query_params)

    respond_with ii
  end

  def show
    ii = InvoiceItem.find_by(query_params)

    respond_with ii
  end
end

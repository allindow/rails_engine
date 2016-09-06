class Api::V1::BaseController < ApplicationController
  respond_to :json, :xml

  def query_params
    request.query_parameters
  end
end

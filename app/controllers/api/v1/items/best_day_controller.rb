class Api::V1::Items::BestDayController < ApplicationController
  def show
    @best_day = Item.find(params[:item_id]).best_day
  end
end

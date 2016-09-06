class Api:V1:CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(parms[:id])
  end
end

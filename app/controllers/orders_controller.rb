class OrdersController < ApplicationController
  protect_from_forgery

  def show
    render :layout => false
  end
end

class AngularViewsController < ApplicationController
  protect_from_forgery

  def orders_new
    render :layout => false
  end

  def orders_index
    render :layout => false
  end
end

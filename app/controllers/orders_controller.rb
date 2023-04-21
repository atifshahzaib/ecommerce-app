# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.includes(:shipment)
  end

  def show
    @order = current_user.orders.includes(:shipment).find(params[:id])
  end
end

# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def create
    return redirect_to new_user_session_path, notice: 'Login first to checkout.' if current_user.blank?

    order_service = OrderService.new(current_user)

    if order_service.create!
      redirect_to shipment_path(order_service.shipment), notice: 'Thank you being interested for this order, please complete shipment to place the order'
    else
      redirect_to products_path, alert: 'Sorry something went wrong while creating order'
    end
  end
end

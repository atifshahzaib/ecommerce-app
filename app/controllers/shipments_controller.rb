# frozen_string_literal: true

class ShipmentsController < ApplicationController
  before_action :set_shipment
  def show; end

  def update
    if @shipment.update(shipment_params.merge(status: 'completed'))
      redirect_to products_path, notice: 'Congratulations! Your order was successful, will be delivered in 3-5 working days'
    else
      redirect_to request.referer, alert: 'Sorry something went wrong while confirming order'
    end
  end

  private

  def set_shipment
    @shipment = Shipment.includes(:user, :order).find(params[:id])
  end

  def shipment_params
    params.require(:shipment).permit(:customer_name, :shipping_address, :phone_number, :payment_method, :order_id)
  end
end

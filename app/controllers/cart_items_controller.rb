# frozen_string_literal: true

class CartItemsController < ApplicationController
  include CartItemHelper

  def index
    if current_user.present?
      @cart_items = CartItem.with_current_user(current_user.id)
    else
      session[:cart] = {} if session[:cart].nil?
      @cart_items = []
      session[:cart].each do |key, value|
        @cart_items.push CartItem.new(product_id: key.to_i, quantity: value) unless Product.find_by(id: key.to_i).nil?
        session[:cart].delete(key) if Product.find_by(id: key.to_i).nil?
      end
    end
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    current_user.present? ? create_cart(cart_item) : add_to_session(cart_item.quantity)
    redirect_to :cart_items
  end

  def update
    if current_user.present?
      @cart_item = CartItem.with_product_id(params[:product_id].to_i).with_current_user(current_user.id)
      @cart_item.update(cart_item_params) if params[:quantity].to_i.positive?
    else
      @cart_item = CartItem.new(product_id: params[:product_id].to_i, quantity: 1)
      session[:cart][params[:product_id]] = @cart_item.quantity = params[:quantity].to_i if params[:quantity].to_i.positive?
    end
  end

  def destroy
    begin
      if current_user.present?
        @cart_item = CartItem.with_product_id(params[:id].to_i).with_current_user(current_user.id)
        @cart_item.destroy
      else
        @cart_item = CartItem.new(product_id: params[:id], quantity: session[:cart][params[:id]])
        session[:cart].delete(params[:id])
      end
      flash[:notice] = 'Product has been removed from cart.'
    rescue StandardError
      flash[:alert] = 'Item not found.'
    end
    redirect_to :cart_items
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end

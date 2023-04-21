# frozen_string_literal: true

module LoadCart
  extend ActiveSupport::Concern

  included do
    def after_sign_in_path_for(_resource)
      session[:cart] = {} if session[:cart].nil?
      update_cart
      update_session
    end
  end

  def update_cart
    items = session[:cart]
    return unless items.length.positive?

    items.each do |key, value|
      Product.find_by(id: key.to_i).tap do |product|
        next if product.nil?

        if product.user.id == current_user.id
          flash[:notice] = 'You have added your item in cart before login. So, it has been removed from your cart.'
          next
        end
        CartItem.find_or_create_by(user_id: current_user.id, product_id: key.to_i).tap do |c|
          c.quantity = value if c.quantity.zero?
          c.save!
        end
      end
    end
  end

  def update_session
    session[:cart] = {}
    cart_items = CartItem.with_current_user(current_user.id)
    cart_items.each { |item| session[:cart][item.product_id.to_s] = item.quantity } if cart_items.count.positive?
    stored_location_for(resource) || root_path
  end
end

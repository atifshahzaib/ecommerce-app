# frozen_string_literal: true

module CartItemHelper
  def create_cart(cart_item)
    CartItem.find_or_create_by(product_id: cart_item.product_id, user_id: current_user.id).tap do |c|
      c.quantity += cart_item.quantity

      if c.quantity > c.product.quantity
        c.quantity = c.product.quantity
        flash[:alert] = "This product has only #{c.product.quantity} items in stock."
      else
        flash[:notice] = "#{cart_item.product.name} is added to cart."
      end
      c.save!
    end
  end

  def add_to_session(quantity)
    session[:cart] = {} if session[:cart].nil?
    product_id = params['cart_item']['product_id']
    session[:cart][product_id] = session[:cart][product_id] ? (session[:cart][product_id] + params[:quantity].to_i) : quantity

    Product.find(product_id.to_i).tap do |p|
      if session[:cart][product_id] > p.quantity
        session[:cart][product_id] = p.quantity
        flash[:alert] = "This product has only #{p.quantity} items in stock."
      else
        flash[:notice] = "#{p.name} is added to cart."
      end
    end
  end
end

# frozen_string_literal: true

class OrderService
  attr_reader :shipment

  def initialize(current_user)
    @current_user = current_user
  end

  def create!
    success = true

    Order.transaction do
      @order = Order.create(user: @current_user,
                            amount_paid: amount_paid)
      build_order_items

      result = OrderItem.import(@order_items)
      raise ActiveRecord::RecordInvalid if result.failed_instances.any?

      update_products_stock
      @cart_items.destroy_all
      @shipment = Shipment.create!(user: @current_user, order: @order, payment_method: 'cash_on_delivery', customer_name: @current_user.full_name,
                                   shipping_address: 'somewhere', phone_number: '1231122')

    rescue ActiveRecord::RecordInvalid => e
      success = false
      raise ActiveRecord::Rollback
    end

    success
  end

  private

  def build_order_items
    @order_items = line_items.map do |line_item|
      {
        product_id: line_item[:product_id],
        price: line_item[:amount],
        quantity: line_item[:quantity],
        order_id: @order.id
      }
    end
  end

  def line_items
    @cart_items ||= CartItem.with_current_user(@current_user.id).includes(:product)
    @cart_items.map do |cart_item|
      {
        product_id: cart_item.product_id,
        amount: (cart_item.product.price * 100).to_i,
        currency: 'usd',
        quantity: cart_item.quantity
      }
    end
  end

  def amount_paid
    line_items.inject(0) { |total, item| total + item[:amount] }
  end

  def update_products_stock
    products = @cart_items.map(&:product)

    products.each do |product|
      product.quantity = product.quantity - @cart_items.find { |item| item.product == product }.quantity
      product.updated_at = DateTime.current if product.changed?
    end

    Product.import products.to_ary, on_duplicate_key_update: { columns: %i[quantity updated_at] }
  end
end

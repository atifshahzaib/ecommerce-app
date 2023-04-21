# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true }

  scope :with_current_user, ->(id) { where(user_id: id) }
  scope :with_product_id, ->(product_id) { find_by(product_id: product_id) }
end

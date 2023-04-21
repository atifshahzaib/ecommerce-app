# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { pending_shipment: 0, completed: 1 }

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_one :shipment, dependent: :destroy

  validates :amount_paid, presence: true, numericality: { only_decimal: true }
end

# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :shipments, through: :order
  validates :full_name, presence: true, length: { minimum: 6, maximum: 25 }

  def thumbnail(width)
    image.variant(resize: width).processed if image.attached?
  end
end

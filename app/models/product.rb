# frozen_string_literal: true

class Product < ApplicationRecord
  # Relations
  belongs_to :user

  has_many_attached :images

  validates :name, presence: true
  validates :description, length: { minimum: 10, maximum: 250 }
  validates :price, presence: true, numericality: { only_decimal: true }
  validates :quantity, presence: true, numericality: { only_integer: true }

  def thumbnail(input, width)
    images[input].variant(resize: width).processed if images.attached?
  end
end

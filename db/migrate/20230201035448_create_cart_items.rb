# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, null: false, default: 0
      t.references :user, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end

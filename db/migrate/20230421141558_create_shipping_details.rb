# frozen_string_literal: true

class CreateShippingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.string :customer_name, null: false, default: ''
      t.string :shipping_address, null: false, default: ''
      t.string :phone_number, null: false, default: ''
      t.string :payment_method, null: false, default: ''
      t.integer :status, null: false, default: 0
      t.references :user, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end

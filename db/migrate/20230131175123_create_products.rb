# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.decimal :price, null: false, default: 1
      t.integer :quantity, null: false, default: 5
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end

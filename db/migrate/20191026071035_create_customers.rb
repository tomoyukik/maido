# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.integer :uuid, unique: true
      t.integer :point, default: 0

      t.index :uuid

      t.timestamps
    end
  end
end

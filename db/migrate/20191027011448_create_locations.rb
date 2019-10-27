# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.integer :code, unique: true
      t.string :name
      t.integer :store_id

      t.index :code
      t.index :store_id

      t.timestamps
    end
  end
end

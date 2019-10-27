# frozen_string_literal: true

class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.integer :customer_id
      t.integer :location_id

      t.timestamps
    end
  end
end

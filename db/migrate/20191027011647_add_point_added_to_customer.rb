# frozen_string_literal: true

class AddPointAddedToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :point_added, :boolean, default: false
  end
end

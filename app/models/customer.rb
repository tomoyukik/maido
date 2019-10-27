# frozen_string_literal: true

class Customer < ApplicationRecord
  attribute :point, :integer, default: 0
  attribute :point_added, :boolean, default: false

  has_many :histories
end

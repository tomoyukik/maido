# frozen_string_literal: true

class Customer < ApplicationRecord
  attribute :point, :integer, default: 0

  has_many :histories
end

# frozen_string_literal: true

class History < ApplicationRecord
  belongs_to :customer
  belongs_to :location
end

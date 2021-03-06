# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed = 0
9.times do
  seed += 11_111
  uuid = seed
  Customer.create(uuid: uuid)
end

5.times do
  uuid = Random.rand(11_111..99_999)
  point = Random.rand(1..100)
  Customer.create(uuid: uuid, point: point) unless Customer.exists?(uuid: uuid)
end

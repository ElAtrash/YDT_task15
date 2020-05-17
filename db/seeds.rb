# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Cleaning Database...'
Article.delete_all

puts 'Creating Articles...'
20.times do
  Article.create(
    title: Faker::Lorem.unique.sentence(word_count: 3, supplemental: true),
    body: Faker::Lorem.unique.paragraph_by_chars(number: 500, supplemental: false)
  )
end

puts 'Done!'

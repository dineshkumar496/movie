# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

#createing admin users

User.create!(email:"dinesh@gmail.com", password:'123456', admin:true)
User.create!(email:"dinesh1@gmail.com", password:'123456', admin:true)
User.create!(email:"dinesh2@gmail.com", password:'123456', admin:true)

#creating movies
50.times do |_n|
  name = Faker::Movie.title
  release_date = Faker::Date.between(from: '1980-01-01', to: '2023-04-23')
  Movie.create!(name:, release_date:)
end

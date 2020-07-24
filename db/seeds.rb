# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.destroy_all
User.destroy_all

require 'open-uri'

# Create Users
anne = User.new(
  email: 'anne_lissner@gmx.net',
  password: '123456'
  )
anne.save

# Create Projects
project1 = Project.new(
  title: 'Blue Summer Top',
  status: 'draft',
  description: 'Use Korfu crop top pattern and make it a bit shorter?',
  user_id: anne.id
  )
project1.save

project2 = Project.new(
  title: 'Red High-Waist Jeans',
  status: 'in progress',
  description: 'Use dark grey pants pattern as basis.',
  user_id: anne.id
  )
project2.save

project3 = Project.new(
  title: 'Pineapple Summer Top',
  status: 'completed',
  description: 'Pink viscose from Barcelona plus green bias binding.',
  adjustments: 'Increased bust circumference and made it a bit longer.',
  user_id: anne.id
  )
project3.save

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Project.destroy_all
#User.destroy_all
Pattern.destroy_all

require 'open-uri'

# Create Users
if !User.find_by(email: "anne_lissner@gmx.net")
  puts "Not found"
  anne = User.new(
    email: "anne_lissner@gmx.net",
    password: "123456"
    )
  anne.save
else
  anne = User.find_by(email: "anne_lissner@gmx.net")
end

# Create Patterns
pattern1 = Pattern.new(
  title: "Korfu Crop Top",
  designer: "Self Drafted",
  fabric_type: "Woven",
  garment_category: "Tops",
  user_id: anne.id
  )
pattern1.save

pattern2 = Pattern.new(
  title: "Dark Grey Jeans",
  designer: "123 Patterns",
  fabric_type: "Knit",
  garment_category: "Pants",
  user_id: anne.id
  )
pattern2.save

# Create Projects
project1 = Project.new(
  title: 'Blue Summer Top',
  status: 'Draft',
  garment_category: 'Tops',
  description: 'Use Korfu crop top pattern and make it a bit shorter?',
  user_id: anne.id,
  pattern_id: pattern1.id
  )
project1.save

project2 = Project.new(
  title: 'Red High-Waist Jeans',
  status: 'In progress',
  garment_category: 'Pants',
  description: 'Use dark grey pants pattern as basis.',
  user_id: anne.id,
  pattern_id: pattern2.id
  )
project2.save

project3 = Project.new(
  title: 'Pineapple Summer Top',
  status: 'Completed',
  garment_category: 'Tops',
  description: 'Pink viscose from Barcelona plus green bias binding.',
  adjustments: 'Increased bust circumference and made it a bit longer.',
  user_id: anne.id,
  pattern_id: pattern1.id
  )
project3.save

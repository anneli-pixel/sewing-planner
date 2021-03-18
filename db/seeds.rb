# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Fabric.destroy_all
ShoppingItem.destroy_all
Project.destroy_all
#User.destroy_all
Pattern.destroy_all

require 'open-uri'

# Create Users
puts "Finding or creating user 'Anne'..."
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

puts "Done."

# Garment Category
puts "Finding garment categories..."
pants_category = GarmentCategory.find_by(name: "Pants")
pullover_cardigans_category = GarmentCategory.find_by(name: "Pullover/Cardigans")
tops_category = GarmentCategory.find_by(name: "Tops")
dresses_category = GarmentCategory.find_by(name: "Dresses")
skirts_category = GarmentCategory.find_by(name: "Skirts")
underwear_category = GarmentCategory.find_by(name: "Underwear")
outerwear_category = GarmentCategory.find_by(name: "Outerwear")

puts "Done."

# Create Patterns
puts "Creating patterns..."

pattern1 = Pattern.new(
  title: "Korfu Crop Top",
  designer: "Self Drafted",
  fabric_type: "Woven",
  notes: "Turned out to be a bit short. Lengthen by 5cm.",
  garment_category_id: tops_category.id,
  user_id: anne.id
  )
pattern1.save

pattern2 = Pattern.new(
  title: "MN Dawn Jeans",
  designer: "Megan Nilsen",
  fabric_type: "Woven",
  notes: "Very high waist.",
  garment_category_id: pants_category.id,
  pattern_url: "https://megannielsen.com/products/dawn-jeans-4-in-1-sewing-pattern",
  user_id: anne.id
  )
pattern2.save

pattern3 = Pattern.new(
  title: "Driftless Cardigan",
  designer: "Grainline Studio",
  fabric_type: "Knit",
  notes: "",
  garment_category_id: pullover_cardigans_category.id,
  pattern_url: "https://grainlinestudio.com/products/driftless-cardigan?variant=22533583405138",
  user_id: anne.id
  )
pattern3.save

puts "Done."

# Create Projects

puts "Creating projects..."

project1 = Project.new(
  title: 'Cream Summer Top',
  status: 'Draft',
  description: 'Use Korfu crop top pattern and make it a bit shorter?',
  size: "S",
  user_id: anne.id,
  pattern_id: pattern1.id
  )
project1.save

project2 = Project.new(
  title: 'Red High-Waist Jeans',
  status: 'In progress',
  description: 'Widen at the side seam?',
  size: "38",
  user_id: anne.id,
  pattern_id: pattern2.id
  )
project2.save

project3 = Project.new(
  title: 'Pineapple Summer Top',
  status: 'Completed',
  description: 'Use green bias binding as contrast.',
  size: "36",
  user_id: anne.id,
  pattern_id: pattern1.id
  )
project3.save

project4 = Project.new(
  title: 'Blue Cardigan for Franzi',
  status: 'Draft',
  description: 'Shorten at the waist?',
  size: "6",
  user_id: anne.id,
  pattern_id: pattern3.id
  )
project4.save

puts "Done."

# Create Fabrics

puts "Creating fabrics..."

fabric1 = Fabric.new(
  title: "Blue Wool Cotton Mix",
  project_id: project4.id
  )
fabric1.save

fabric2 = Fabric.new(
  title: "Pink viscose from Barcelona",
  project_id: project3.id
  )
fabric2.save

fabric3 = Fabric.new(
  title: "Plain green viscose from Lisbon",
  project_id: project3.id
  )
fabric3.save

fabric4 = Fabric.new(
  title: "Dark red denim from Holland Stoffmarkt",
  project_id: project2.id
  )
fabric4.save

fabric5 = Fabric.new(
  title: "Cream seersucker fabric",
  project_id: project1.id
  )
fabric5.save

puts "Done."

# Create Shopping items

puts "Creating Shopping items..."

item1 = ShoppingItem.new(
  name: "5 Jeans Buttons",
  user_id: anne.id,
  project_id: project2.id,
  bought: false,
  )
item1.save

item2 = ShoppingItem.new(
  name: "10 Rivets",
  user_id: anne.id,
  project_id: project2.id,
  bought: true,
  )
item2.save

item3 = ShoppingItem.new(
  name: "White Stretch Interfacing",
  user_id: anne.id,
  project_id: project1.id,
  bought: false,
  )
item3.save

item4 = ShoppingItem.new(
  name: "Stretch Needles",
  user_id: anne.id,
  bought: false,
  )
item4.save

item5 = ShoppingItem.new(
  name: "Tracing Paper",
  user_id: anne.id,
  bought: true,
  )
item5.save

puts "Done"
puts "Seeds complete."

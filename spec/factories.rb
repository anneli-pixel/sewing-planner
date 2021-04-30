FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { "Fd392&sKx?" }
  end

  factory :garment_category do
    name { "Cardigans" }
  end

  factory :pattern do
    association :user
    association :garment_category
    title { "Driftless Cardigan" }
    designer { "Grainline Studio" }
    fabric_type { "Knit" }
    pattern_url { "" }
    notes { "" }
  end

  factory :project do
    association :user
    association :pattern
    title { "Blue Winter Cardigan" }
    size { "M" }
    status { "Draft" }
  end

  factory :fabric do
    association :project
    title { "Blue Wool Cotton Interlock Knit" }
  end

  factory :shopping_item do
    association :user
    association :project
    name { "10 Buttons" }
  end
end

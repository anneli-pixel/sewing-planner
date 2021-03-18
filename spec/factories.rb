FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { "Fd392&sKx?" }
  end

  factory :garment_category do
    name { "Pullover/Cardigans" }
  end

  factory :pattern do
    association :user
    association :garment_category
    title { "Driftless Cardigan" }
    designer { "Grainline Studio" }
    fabric_type { "Knit" }
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
end

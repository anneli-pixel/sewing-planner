FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "Fd392&sKx?" }
  end

  factory :garment_category do
    name { "Pullover/Cardigans" }
  end
end

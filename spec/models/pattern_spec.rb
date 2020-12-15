require 'rails_helper'

RSpec.describe Pattern, type: :model do
  subject do
    user = User.create(id: 1, email: "anne_lissner@gmx.net", password: "123456")
    Pattern.new(title: "Barbara Sweater",
                designer: "123 Patterns",
                fabric_type: "Knit",
                pattern_url: "www.123patterns.com/barbara-sweater",
                garment_category: "Pullover/Cardigans",
                notes: "Sleeves rather tight, add 2 cm width.",
                user_id: user.id)
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:projects) }
  end

  describe "Validations" do
    fabric_type_message = "must be #{Pattern::FABRIC_TYPES[0..-2].join(", ")} or #{Pattern::FABRIC_TYPES.last}."
    garment_category_message = "must be #{Pattern::GARMENT_CATEGORIES[0..-2].join(", ")} or #{Pattern::GARMENT_CATEGORIES.last}."
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:designer) }
    it { should validate_presence_of(:fabric_type).with_message(fabric_type_message) }

    it do
      should validate_inclusion_of(:fabric_type).in_array(Pattern::FABRIC_TYPES).with_message(fabric_type_message)
    end

    it { should validate_presence_of(:garment_category).with_message(garment_category_message) }
    it do
      should validate_inclusion_of(:garment_category).in_array(Pattern::GARMENT_CATEGORIES).with_message(garment_category_message)
    end


    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end
end

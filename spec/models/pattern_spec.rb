require 'rails_helper'

RSpec.describe Pattern, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  subject do
    user = User.new(id: 1)
    Pattern.new(title: "Barbara Sweater",
                designer: "123 Patterns",
                fabric_type: "Knit",
                pattern_url: "www.123patterns.com/barbara-sweater",
                garment_category: "Pullover/Cardigans",
                notes: "Sleeves rather tight, add 2 cm width.",
                user_id: user.id)
  end

  it "is valid with valid attributes" do
    # user = User.new(id: 1)
    # pattern = Pattern.new(title: "Barbara Sweater",
    #                       designer: "123 Patterns",
    #                       fabric_type: "Knit",
    #                       pattern_url: "www.123patterns.com/barbara-sweater",
    #                       garment_category: "Pullover/Cardigans",
    #                       notes: "Sleeves rather tight, add 2 cm width.",
    #                       user_id: user.id)
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
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

  # context "valid title" do
  #   it "is invalid without a title" do
  #     subject.title = nil
  #     expect(subject).to_not be_valid
  #   end
  #   it "has to be unique" do
  #     pattern_2 = subject.clone
  #     puts subject.title
  #     puts pattern_2.title
  #     expect(pattern_2).to_not be_valid
  #   end
  # end

  # it "is invalid without a designer" do
  #   pattern = Pattern.new(designer: nil)
  #   expect(pattern).to_not be_valid
  # end

  # context "valid fabric type" do
  #   it "is invalid without a fabric type" do
  #     pattern = Pattern.new(fabric_type: nil)
  #     expect(pattern).to_not be_valid
  #   end

  #   it "is valid when it is included in FABRIC_TYPES" do
  #     pattern = Pattern.new(fabric_type: "Knit")
  #     expect(Pattern::FABRIC_TYPES).to include(pattern.fabric_type)
  #   end
  # end
end

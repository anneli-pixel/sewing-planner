require 'rails_helper'

RSpec.describe Pattern, type: :model do
  let(:user_factory) { create(:user) }

  let(:garment_category_factory) { create(:garment_category) }

  subject { described_class.new(valid_attributes_hash) }

  let(:valid_attributes_hash) do
    {
      title: "Barbara Sweater",
      designer: "123 Patterns",
      fabric_type: "Knit",
      pattern_url: "www.123patterns.com/barbara-sweater",
      garment_category_id: garment_category_factory.id,
      notes: "Sleeves rather tight, add 2 cm width.",
      user_id: user_factory.id
    }
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:projects) }
    it { should belong_to(:garment_category) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:designer) }
    it { should validate_presence_of(:fabric_type) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end

end

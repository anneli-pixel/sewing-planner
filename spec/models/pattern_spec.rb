require 'rails_helper'

RSpec.describe Pattern, type: :model do
  subject { create(:pattern) }

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

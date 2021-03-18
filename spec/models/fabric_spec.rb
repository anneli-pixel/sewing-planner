require 'rails_helper'

RSpec.describe Fabric, type: :model do
  let(:project) { create(:project) }

  subject { described_class.new(valid_attributes_hash) }

  let(:valid_attributes_hash) do
    {
      title: "Blue Wool Cotton Interlock Knit",
      project_id: project.id
    }
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:project) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
  end
end

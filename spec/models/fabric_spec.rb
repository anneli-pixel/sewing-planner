require 'rails_helper'

RSpec.describe Fabric, type: :model do
  subject { create(:fabric) }

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

require 'rails_helper'

RSpec.describe Fabric, type: :model do
  subject do
    user = User.create(email: "test@example.com", password: "Fd392&sKx?")
    pattern = Pattern.create(title: "Inari Tee",
                          designer: "Named Patterns",
                          fabric_type: "Knit",
                          garment_category: "Tops",
                          user_id: user.id)
    project = Project.create(title: "Crop Top",
                             size: "M",
                             status: "Draft",
                             pattern_id: pattern.id,
                             user_id: user.id)
    Fabric.new(title: "Blue Cotton with Black Dots",
               project_id: project.id)
  end

  describe "Associations" do
    it { should belong_to(:project) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end

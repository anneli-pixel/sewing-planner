require 'rails_helper'

RSpec.describe Fabric, type: :model do
  subject do
    user = User.create(id: 1, email: "anne_lissner@gmx.net", password: "123456")
    pattern = Pattern.create(title: "Inari Tee",
                          designer: "Named Patterns",
                          fabric_type: "Knit",
                          garment_category: "Tops",
                          user_id: user.id)
    project = Project.create(id: 1,
                             title: "Crop Top",
                             status: "Draft",
                             pattern_id: pattern.id,
                             user_id: user.id)
    Fabric.new(title: "Blue Cotton with Black Dots",
               user_id: user.id,
               project_id: project.id)
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end
end

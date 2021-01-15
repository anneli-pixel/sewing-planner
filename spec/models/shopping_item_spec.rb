require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do
    subject do
      user = User.create(email: "test@example.com", password: "Fd392&sKx?")
      project = Project.new(title: "Crop Top",
                            status: "Draft",
                            size: "M",
                            user_id: user.id
                            )
      shopping_item = ShoppingItem.new(name: "10 Buttons",
                                       user_id: user.id,
                                       project_id: project.id)
    end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project).optional}
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe "Valid attributes" do

    it "is valid without a project" do
      subject.project_id = nil
      expect(subject).to be_valid
    end

    it "is valid with a project" do
      expect(subject).to be_valid
    end
  end
end

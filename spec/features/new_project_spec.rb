require 'rails_helper'

RSpec.feature "New project page" do
  before(:example) do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    pattern = Pattern.create(title: "Inari Tee",
                designer: "Named Patterns",
                fabric_type: "Knit",
                garment_category: "Tops",
                user_id: user.id)
    visit new_project_path
  end

  after(:example) do
    Warden.test_reset!
  end

  describe "Form creates new project:" do
    it "With valid and required information" do
      before_count = Project.count
      within("#new_project") do
        fill_in "project_title", with: "Blue Summer Crop Top"
        select("Inari Tee", from: "project_pattern_id")
        fill_in "project_size", with: "S"
        select("Draft", from: "project_status")
      end
      click_on("Save Project")
      expect(Project.count).not_to eq(before_count)
    end

    it "With optional information" do
      before_count = Project.count
      within("#new_project") do
        fill_in "project_title", with: "Blue Summer Crop Top"
        select("Inari Tee", from: "project_pattern_id")
        fill_in "project_fabrics_attributes_0_title", with: "Light Blue Cotton with Dots"
        fill_in "project_fabrics_attributes_1_title", with: "Dark Blue Cotton"
        fill_in "project_size", with: "S"
        select("Draft", from: "project_status")
      end
      click_on("Save Project")
      expect(Project.count).not_to eq(before_count)
    end
  end
end

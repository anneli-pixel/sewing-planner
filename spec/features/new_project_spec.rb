require 'rails_helper'

RSpec.feature "New project page" do
  let(:user) { User.find(pattern.user_id) }
  let(:garment_category) { create(:garment_category) }
  let(:pattern) { create(:pattern) }

  before(:example) do
    login_as(user, :scope => :user)
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
        select("Driftless Cardigan", from: "project_pattern_id")
        fill_in "project_size", with: "S"
        select("Draft", from: "project_status")
      end
      click_on("Save Project")
      expect(Project.count).not_to eq(before_count)
    end

    it "With optional information" do
      before_count = Project.count
      before_count_fabric = Fabric.count
      within("#new_project") do
        fill_in "project_title", with: "Blue Summer Crop Top"
        select("Driftless Cardigan", from: "project_pattern_id")
        fill_in "project_fabrics_attributes_0_title", with: "Light Blue Cotton with Dots"
        fill_in "project_fabrics_attributes_1_title", with: "Dark Blue Cotton"
        fill_in "project_size", with: "S"
        select("Draft", from: "project_status")
      end
      click_on("Save Project")
      expect(Fabric.count).not_to eq(before_count_fabric)
      expect(Project.count).not_to eq(before_count)
    end

    it "and creates new fabrics" do
      before_count_fabric = Fabric.count
      within("#new_project") do
        fill_in "project_title", with: "Blue Summer Crop Top"
        select("Driftless Cardigan", from: "project_pattern_id")
        fill_in "project_fabrics_attributes_0_title", with: "Light Blue Cotton with Dots"
        fill_in "project_fabrics_attributes_1_title", with: "Dark Blue Cotton"
        fill_in "project_size", with: "S"
        select("Draft", from: "project_status")
      end
      click_on("Save Project")
      expect(Fabric.count).not_to eq(before_count_fabric)
    end
  end
end

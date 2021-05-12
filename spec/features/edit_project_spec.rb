require 'rails_helper'

RSpec.feature "Edit project page" do 
  let(:user) { create(:user) }  
  let(:pattern) { create(:pattern, user_id: user.id) }
  let(:project) { create(:project, user_id: user.id, pattern_id: pattern.id) }
  let!(:new_pattern) { create(:pattern, user_id: user.id, title: "Another pattern") }
  let!(:fabric) { create(:fabric, project_id: project.id) }

  before(:example) do
    login_as(user, :scope => :user)
    visit edit_project_path(project)
  end

  after(:example) do
    Warden.test_reset!  
  end
  
  it "can change the title" do
    within("#edit_project_#{project.id}") do
      fill_in("project_title", with: "A new project title")
    end
    click_on("Save Project")
    expect(page).to have_content("A new project title")
  end

  it "can change the pattern" do
    within("#edit_project_#{project.id}") do
      select(new_pattern.title, from: "project_pattern_id")
    end
    click_on("Save Project")
    expect(page).to have_content("Another pattern")
  end

  it "can add a fabric" do
    # TODO this adds 2 fabrics for some reason 
    before_count = project.fabrics.count
    #puts before_count
    within("#edit_project_#{project.id}") do
      fill_in "project_fabrics_attributes_1_title", with: "New Fabric"
    end
    click_on("Save Project")
    #puts project.fabrics.count
    expect(project.fabrics.count).not_to eq(before_count)
  end

  it "can delete a fabric" do
    before_count = project.fabrics.count
    within("#edit_project_#{project.id}") do
      page.check("project_fabrics_attributes_0__destroy")
    end
    click_on("Save Project")
    expect(project.fabrics.count).to eq(before_count-1)
  end 

  it "can change the description" do
    within("#edit_project_#{project.id}") do
      fill_in("project_description", with: "Some text that describes the project.")
    end
    click_on("Save Project")
    expect(page).to have_content("Some text that describes the project.")
  end

  it "can change the size" do
    within("#edit_project_#{project.id}") do
      fill_in("project_size", with: "38")
    end
    click_on("Save Project")
    expect(page).to have_content("38")
  end

  it "can change the status" do
    within("#edit_project_#{project.id}") do
      select("Completed", from: "project_status")
    end
    click_on("Save Project")
    expect(page).to have_content("Completed")
  end

#   it "can add a project image" do
#   end

#   it "can change the project image" do
#     # TODO
#   end

#   it "can delete the project image" do
#     # TODO
#   end

#   it "shows a thumbnail of the project image" do
#   end
end
 
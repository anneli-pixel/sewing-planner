require 'rails_helper'

RSpec.feature "New Shopping Item Page" do
  let(:user) { User.find(project.user_id) }
  let(:project) { create(:project) }

  before(:example) do
    login_as(user, :scope => :user)
    visit new_shopping_item_path
  end

  after(:example) do
    Warden.test_reset!
  end

  describe "Form creates new shopping item:" do
    it "for a project" do
      before_count = ShoppingItem.count
      within("#new_shopping_item") do
        fill_in "shopping_item_name", with: "3 Buttons"
        select(project.title, from: "shopping_item_project_id")
      end
      click_on("Save")
      expect(ShoppingItem.count).not_to eq(before_count)
    end

    it "individually (without a project)" do
      before_count = ShoppingItem.count
      within("#new_shopping_item") do
        fill_in "shopping_item_name", with: "3 Buttons"
      end
      click_on("Save")
      expect(ShoppingItem.count).not_to eq(before_count)
    end
  end
end

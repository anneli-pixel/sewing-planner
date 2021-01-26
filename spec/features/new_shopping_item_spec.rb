require 'rails_helper'

RSpec.feature "New Shopping Item Page" do
  let(:user) do
    User.create!(email: 'test@example.com',
                 password: 'f4k3p455w0rd')
  end

  let(:pattern) do
    Pattern.create!(title: "Inari Tee",
                designer: "Named Patterns",
                fabric_type: "Knit",
                garment_category: "Tops",
                user: user)
  end

  let(:project) do
    Project.create!(title: "Blue Summer Top",
                    size: "M",
                    status: "Draft",
                    pattern: pattern,
                    user: user)
  end

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
        select(from: "shopping_item_project_id")
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

require 'rails_helper'

RSpec.feature "New pattern page" do
  before(:example) do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    visit new_pattern_path
  end

  after(:example) do
    Warden.test_reset!
  end

  describe "Page shows form fields for:" do
    it "Title" do
      expect(page).to have_field(id: "pattern_title")
    end

    it "Designer" do
      expect(page).to have_field(id: "pattern_designer")
    end

    describe "Fabric Types" do
      it "Knit" do
        expect(page).to have_field(id: "pattern_fabric_type_knit")
      end

      it "Woven" do
        expect(page).to have_field(id: "pattern_fabric_type_woven")
      end
    end

    describe "Garment Categories" do
        Pattern::GARMENT_CATEGORIES.each do |category|
          it "#{category}" do
            expect(page).to have_field(id: "pattern_garment_category_#{category.downcase.gsub("/", "")}")
          end
        end
    end

    it "Pattern Url" do
      expect(page).to have_field(id: "pattern_pattern_url")
    end

    it "Notes" do
      expect(page).to have_field(id: "pattern_notes")
    end
  end

  describe "Form creates new pattern:" do
    it "With valid and required information" do
      within("#new_pattern") do
        fill_in "pattern_title", with: "Inari Tee"
        fill_in("pattern_designer", with: "Named Patterns")
        choose ("pattern_fabric_type_knit")
        find("#pattern_garment_category_tops", :visible => false).click
      end
      click_on("Save Pattern")
      expect(page).to have_content "Pattern successfully created."
    end

    it "with optional information" do
      within("#new_pattern") do
        fill_in "pattern_title", with: "Inari Tee"
        fill_in("pattern_designer", with: "Named Patterns")
        choose ("pattern_fabric_type_knit")
        find("#pattern_garment_category_tops", :visible => false).click
        fill_in "pattern_pattern_url", with: "www.named-patterns.com/inari-tee"
        fill_in "pattern_notes", with: "Some notes about this pattern."
      end
      click_on("Save Pattern")
      expect(page).to have_content "Pattern successfully created."
    end
  end
end

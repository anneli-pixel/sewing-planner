require 'rails_helper'

RSpec.feature "New pattern page" do
  let!(:garment_category) { create(:garment_category) }
  let(:user) { create(:user) }

  before(:example) do
    login_as(user, :scope => :user)
    visit new_pattern_path
  end

  after(:example) do
    Warden.test_reset!
  end

  describe "Form creates new pattern:" do
    it "With valid and required information" do
      before_count = Pattern.count
      within("#new_pattern") do
        fill_in "pattern_title", with: "Driftless Cardigan"
        fill_in("pattern_designer", with: "Grainline Studio")
        choose ("pattern_fabric_type_knit")
        choose("pattern_garment_category_id_#{garment_category.id}")
      end
      click_on("Save Pattern")
      expect(Pattern.count).to eq(before_count + 1)
    end

    it "with optional information" do
      before_count = Pattern.count
      within("#new_pattern") do
        fill_in "pattern_title", with: "Driftless Cardigan"
        fill_in("pattern_designer", with: "Grainline Studio")
        choose ("pattern_fabric_type_knit")
        choose("pattern_garment_category_id_#{garment_category.id}")
        fill_in "pattern_pattern_url", with: "www.grainline-studio.com/driftless-cardigan"
        page.choose("pattern_purchased_true")
        fill_in "pattern_notes", with: "Some notes about this pattern."
      end
      click_on("Save Pattern")
      expect(Pattern.count).to eq(before_count + 1)
    end
  end
end

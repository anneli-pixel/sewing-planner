require 'rails_helper'

# Data I have put into the database in my test code will invisible to Capybara, that's why I have to check for page content.

RSpec.feature "Edit pattern page" do
  let(:user) { User.find(pattern.user_id) }
  let(:pattern) { create(:pattern) }
  let!(:new_garment_category) { create(:garment_category, name: "Pullovers") }


  before(:example) do
    login_as(user, :scope => :user)
    visit edit_pattern_path(pattern)
  end

  after(:example) do
    Warden.test_reset!  
  end

  it "can add a pattern image" do
   # TODO
    @photo = fixture_file_upload('files/placeholder.png')
  end

  it "can change the pattern image" do
    # TODO
  end

  it "can delete the pattern image" do
    # TODO
  end

  it "can change the pattern title" do
    within("#edit_pattern_#{pattern.id}") do
      fill_in("pattern_title", with: "new title")
    end
    click_on("Save Pattern")
    expect(page).to have_content("new title") 
  end

  it "can change the pattern designer" do
    within("#edit_pattern_#{pattern.id}") do
    fill_in("pattern_designer", with: "new designer")
    end
    click_on("Save Pattern")
    expect(page).to have_content("new designer")
  end

  it "can change the fabric type" do
    within("#edit_pattern_#{pattern.id}") do
    choose("pattern_fabric_type_woven")
    end
    click_on("Save Pattern")
    pattern_card = find_by_id("#{pattern.id}")
    expect(pattern_card).to have_content("Woven")
  end

  it "can change the garment category" do
    within("#edit_pattern_#{pattern.id}") do
    choose("pattern_garment_category_id_#{new_garment_category.id}")
    end
    click_on("Save Pattern")
    expect(page).to have_css('img', id: 'pullovers')
  end

  it "can change the pattern url" do
    # TODO How can I test this? Url does not appear on the index page. 
    # within("#edit_pattern_#{pattern.id}") do
    # fill_in("pattern_pattern_url", with: "www.new-pattern-url.com")
    # end
    # click_on("Save Pattern")
    # expect(page).to have_link(href: "http://www.new-pattern-url.com")
  end

  it "can change the notes" do
    # TODO How can I test this? Notes do not appear on the index page. 
  end

  it "can be purchased" do
    within("#edit_pattern_#{pattern.id}") do
      page.choose("pattern_purchased_true")
    end
    click_on("Save Pattern")
    expect(Pattern.last.purchased).to eq(true)
  end
end
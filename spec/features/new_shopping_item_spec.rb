require 'rails_helper'

RSpec.feature "New Shopping Item Page" do
  before(:example) do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd')
    login_as(user, :scope => :user)
    visit shopping_items_path
  end

  after(:example) do
    Warden.test_reset!
  end

  describe "Form creates new shopping item:" do
    it "for a project" do
      before_count = ShoppingItem.count
      within("#new_shopping_item") do

      end
    end

    it "without a project" do

    end
  end
end

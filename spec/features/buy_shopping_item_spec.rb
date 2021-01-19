require'rails_helper'

RSpec.feature "Buy Shopping Item" do
  before(:example) do
    user = User.create!(email: 'test@example.com',
                        password: 'f4k3p455w0rd')
    @shopping_item = ShoppingItem.create!(name: "3 Buttons",
                                         user: user)
    login_as(user, :scope => :user)
    visit shopping_items_path
  end

  after(:example) do
    Warden.test_reset!
  end

  it "Can be checked as bought" do
    puts page.has_content?("3 Buttons")
    click_link(id: "#{@shopping_item.id}")
    expect(@shopping_item.bought).to eq(true)
  end
end

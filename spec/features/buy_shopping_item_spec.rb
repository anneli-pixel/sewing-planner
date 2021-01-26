require'rails_helper'

RSpec.feature "Buy Shopping Item" do

  let(:user) do
    User.create!(email: 'test@example.com',
                 password: 'f4k3p455w0rd')
  end

  let!(:shopping_item) do
    ShoppingItem.create!(name: "3 Buttons",
                         bought: false,
                         user: user)
  end

  it "Can be checked as bought" do
    login_as(user, :scope => :user)
    visit shopping_items_path
    find_link(id: "#{shopping_item.id}").click
    expect(shopping_item.reload.bought).to be(true)
  end

  after(:example) do
    Warden.test_reset!
  end
end

require'rails_helper'

RSpec.feature "Buy Shopping Item" do

  let!(:user) do
    User.create!(email: 'test@example.com',
                             password: 'f4k3p455w0rd')
  end

  let!(:shopping_item) do
    ShoppingItem.create!(name: "3 Buttons",
                                             bought: false,
                                             user: user)
  end

  it "Can be checked as bought" do
    # user = User.create!(email: 'test@example.com',
    #                      password: 'f4k3p455w0rd')
    # @shopping_item = ShoppingItem.create!(name: "3 Buttons",
    #                                      bought: false,
    #                                      user: user)
    login_as(user, :scope => :user)

    visit shopping_items_path
    before_bought = shopping_item.bought
    puts "BEFORE"
    puts shopping_item.bought
    find_link(id: "#{shopping_item.id}").click
    #click_link(id: "#{@shopping_item.id}")
    print page.html
    puts "AFTER"
    puts shopping_item
    puts shopping_item.bought
    expect(shopping_item.bought).to be(true)
    #expect(link_image).to have_css('item-bought true')

  end

  after(:example) do
    Warden.test_reset!
  end
end

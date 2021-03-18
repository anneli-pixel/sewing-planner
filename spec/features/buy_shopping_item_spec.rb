require'rails_helper'

RSpec.feature "Buy Shopping Item" do
  let(:user) { User.find(shopping_item.user_id) }
  let(:shopping_item) { create(:shopping_item) }

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

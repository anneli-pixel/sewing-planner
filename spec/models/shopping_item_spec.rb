require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do
  subject { create(:shopping_item) }

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project).optional}
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  it "can be bought" do
    subject.buy
    expect(subject.bought).to eq(true)
  end
end

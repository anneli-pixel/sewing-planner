require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do
    subject do
      user = User.create(email: "test@example.com", password: "Fd392&sKx?")
      project = Project.new(title: "Crop Top",
                            status: "Draft",
                            size: "M",
                            user_id: user.id
                            )
      shopping_item = ShoppingItem.new(name: "10 Buttons",
                                       bought: false,
                                       user: user,
                                       project: project)
    end

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

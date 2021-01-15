require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do


  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project).optional}
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end

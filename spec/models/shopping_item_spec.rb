require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do


  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project).optional}
  end

end

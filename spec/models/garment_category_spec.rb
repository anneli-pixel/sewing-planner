require 'rails_helper'

RSpec.describe GarmentCategory, type: :model do
  describe "Associations" do
    it { should have_many(:patterns) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end

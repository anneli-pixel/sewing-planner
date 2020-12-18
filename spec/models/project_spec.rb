require 'rails_helper'

RSpec.describe Project, type: :model do
  subject do
    user = User.create(email: "test@example.com", password: "Fd392&sKx?")
    pattern = Pattern.create(title: "Inari Tee",
                             designer: "Named Patterns",
                             fabric_type: "Knit",
                             garment_category: "Tops",
                             user_id: user.id)
    project = Project.new(title: "Crop Top",
                          status: "Draft",
                          size: "M",
                          pattern_id: pattern.id,
                          user_id: user.id)
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:pattern) }
    it { should have_many(:fabrics) }
  end

  describe "Validations" do
    status_message = "must be #{Project::STATUSES[0..-2].join(", ")} or #{Project::STATUSES.last}."
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:size) }
    it { should validate_inclusion_of(:status).in_array(Project::STATUSES).with_message(status_message) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end

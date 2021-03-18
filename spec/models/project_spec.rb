require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { create(:project) }

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

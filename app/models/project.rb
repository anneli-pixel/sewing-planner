class Project < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: ["draft", "in progress", "completed"] }
  belongs_to :user
end

class Fabric < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :title, presence: true
  validates :title, uniqueness: { scope: :user_id }
end

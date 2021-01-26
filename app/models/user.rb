class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :measurements
  has_many :fabrics
  has_many :project_fabrics, through: :fabrics
  has_many :projects
  has_many :patterns
  has_many :shopping_items
  has_many :project_fabrics, through: :projects
end

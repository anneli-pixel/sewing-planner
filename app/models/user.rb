class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :measurements, dependent: :destroy
  has_many :fabrics, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :patterns, dependent: :destroy
  has_many :shopping_items, dependent: :destroy
end

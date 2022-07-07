class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  validates :username, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :description, length: { minimum: 6 }
end

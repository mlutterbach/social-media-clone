class User < ApplicationRecord
  validates :username, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :description, length: { minimum: 6 }

  has_many :tweets
end

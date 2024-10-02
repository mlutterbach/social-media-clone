class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  # validates :email, presence: true
  # validates :description, length: { minimum: 6 }
end

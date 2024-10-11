class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :content, length: { minimum: 2, maximum: 140 }
  # validates :retweet_count, numericality: { greater_than_or_equal_to: 0 }
  # validates :likes_count, numericality: { greater_than_or_equal_to: 0 }
end

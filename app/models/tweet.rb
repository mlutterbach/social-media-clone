class Tweet < ApplicationRecord
  belongs_to :user

  validates :content, length: { minimum: 2, maximum: 140 }
  validates :retweet_count, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { greater_than_or_equal_to: 0 }
end

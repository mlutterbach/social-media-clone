class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :retweet, class_name: 'Tweet', optional: true
  has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'

  validates :content, length: { minimum: 2, maximum: 140 }
  # validates :retweet_count, numericality: { greater_than_or_equal_to: 0 }
  # validates :likes_count, numericality: { greater_than_or_equal_to: 0 }

  after_create :increment_retweet_count

  private

  def increment_retweet_count
    if retweet_id.present?
      original_tweet = Tweet.find(retweet_id)
      original_tweet.increment!(:retweet_count)
    end
  end
end

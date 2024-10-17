require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let (:user) do
    User.create!(username: 'Anything', password: 'secret', description: "Lorem ipsum", email: "user@email.com", name: "John Lennon")
  end

  let (:valid_attributes) do
    {
      content: "First tweet of the project!",
      retweet_count: 5,
      likes_count: 5,
      user: user,
    }
  end

  let(:original_tweet) do
    Tweet.create!(content: "Original tweet content!", user: user, retweet_count: 0, likes_count: 0)
  end

  it 'has a content' do
    tweet = Tweet.new(content: "", user: user)
    expect(tweet).not_to be_valid
  end

  it 'content cannot be shorter than 2 characters' do
    tweet = Tweet.new(content: "F", user: user)
    expect(tweet).not_to be_valid
  end

  it 'content cannot be larger than 140 characters' do
    tweet = Tweet.new(content: "This string has a 141 characters exactly-it was hard to create, so I hope you appreciate it. Seriously, I put a lot of effort in this project", user: user)
    expect(tweet).not_to be_valid
  end

  it 'belongs to a user' do
    tweet = Tweet.new(user: user)
    expect(tweet.user).to eq(user)
  end

  it 'retweet and likes count to be a positive integer' do
    tweet = Tweet.new(valid_attributes)
    expect(tweet.likes_count).to be >= 0
    expect(tweet.retweet_count).to be >= 0
  end

  it 'increments the retweet count of the original tweet when a retweet is created' do
    retweet = Tweet.create!(content: "Retweeting original tweet", user: user, retweet_id: original_tweet.id)

    original_tweet.reload
    expect(original_tweet.retweet_count).to eq(1)
  end
end

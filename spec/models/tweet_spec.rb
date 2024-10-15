require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let (:name_user) do
    User.create!(username: 'Anything',
      password: 'secret',
      description: "Lorem ipsum",
      email: "user@email.com",
      name: "John Lennon")
  end

  let (:valid_attributes) do
    {
      content: "First tweet of the project!",
      retweet_count: 5,
      likes_count: 5,
      user: name_user,
    }
  end

  it 'has a content' do
    tweet = Tweet.new(content: "", user: name_user)
    expect(tweet).not_to be_valid
  end

  it 'content cannot be shorter than 2 characters' do
    tweet = Tweet.new(content: "F", user: name_user)
    expect(tweet).not_to be_valid
  end

  it 'content cannot be larger than 140 characters' do
    tweet = Tweet.new(content: "This string has a 141 characters exactly-it was hard to create, so I hope you appreciate it. Seriously, I put a lot of effort in this project", user: name_user)
    expect(tweet).not_to be_valid
  end

  it 'belongs to a user' do
    tweet = Tweet.new(user: name_user)
    expect(tweet.user).to eq(name_user)
  end

  it 'retweet and likes count to be a positive integer' do
    tweet = Tweet.new(valid_attributes)
    expect(tweet.likes_count).to be >= 0
    expect(tweet.retweet_count).to be >= 0
  end
end

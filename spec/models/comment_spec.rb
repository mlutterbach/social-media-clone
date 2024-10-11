require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(name: "User 1", username: "User1", email: "user1@example.com", password: "password", description:"A description 1") }
  let(:tweet) { Tweet.create!(content: "First tweet from @User1", user: user) }

  it "is a valid comment with the correct attributes" do
    comment = Comment.new(content: "Wow great tweet", user: user, tweet: tweet)
    expect(comment).to be_valid
  end

  it "is not a valid comment" do
    comment = Comment.new(content: nil)
    expect(comment).to_not be_valid
  end
end

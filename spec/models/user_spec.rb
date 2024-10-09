require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(
    username: 'Anything',
    description: "Lorem ipsum",
    email: "user@email.com",
    name: "John Lennon",
    password: "secret")
  }

  it "is valid with valid attributes" do
    subject.password = 'secret'
    expect(subject).to be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a username" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "has many tweets" do
    user = subject
    expect(user).to respond_to(:tweets)
    expect(user.tweets.count).to eq(0)
  end
end

RSpec.describe User, type: :model do
  let(:user1) { User.create!(name: "User 1", username: "User1", email: "user1@example.com", password: "password", description:"A description 1") }
  let(:user2) { User.create!(name: "User 2", username: "User2", email: "user2@example.com", password: "password", description:"A description 2") }

  describe "follow/unfollow functionality" do
    context "when a user follows another user" do
      it "increments the following count of the follower" do
        user1.follow(user2)
        expect(user1.following_count).to eq(1)
      end

      it "increments the followers count of the followed user" do
        user1.follow(user2)
        expect(user2.followers_count).to eq(1)
      end

      it "does not increment counts if already following" do
        user1.follow(user2)
        expect {
          user1.follow(user2)
        }.not_to change { user1.following_count }
      end
    end

    context "when a user unfollows another user" do
      before do
        user1.follow(user2)
      end

      it "decrements the following count of the follower" do
        user1.unfollow(user2)
        expect(user1.following_count).to eq(0)
      end

      it "decrements the followers count of the followed user" do
        user1.unfollow(user2)
        expect(user2.followers_count).to eq(0)
      end

      it "does not decrement counts if not following" do
        user1.unfollow(user2)
        expect {
          user1.unfollow(user2)
        }.not_to change { user1.following_count }
      end
    end
  end
end

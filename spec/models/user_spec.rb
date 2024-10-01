require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(
    username: 'Anything',
    description: "Lorem ipsum",
    email: "user@email.com",
    name: "John Lennon")
  }

  it "is valid with valid attributes" do
    subject.password = 'secret'
    expect(subject).to be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "description cannot be shorter than 6 characters" do
    subject.description = "Good!"
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

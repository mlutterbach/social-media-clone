require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    expect(User.new).to be_valid
  end

  it "is not valid without a username" do
    user = User.new(username: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a description"
  it "is not valid without a email"
  it "is not valid without a name"
end

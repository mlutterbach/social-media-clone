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

  it "is valid, with followers_count = 0, following_count = 0" do
    expect(subject.followers_count).to eq(0)
    expect(subject.following_count).to eq(0)
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

  describe "profile image attachment" do
    before { subject.save }

    it "is valid without a profile_image" do
      expect(subject.update(profile_image: nil)).to be_truthy
    end

    it "is valid with a valid profile_image" do
      file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_image.jpg'), 'image/jpg')
      expect(subject.update(profile_image: file)).to be_truthy
      expect(subject.profile_image).to be_attached
    end

    it "is not valid with an invalid profile_image type" do
      file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'invalid_image.txt'), 'text/plain')
      expect(subject.update(profile_image: file)).to be_falsey
      expect(subject.errors[:profile_image]).to include("must be a PNG or JPEG image")
    end

    it "is not valid with a profile_image size greater than 5MB" do
      # Create a temporary file that simulates being larger than 5MB
      large_file = Tempfile.new(['large_image', '.jpg'])
      large_file.write('0' * (6 * 1024 * 1024))  # Write 6MB of data
      large_file.rewind

      # Use the Tempfile for the test
      file_to_attach = ActionDispatch::Http::UploadedFile.new(
        tempfile: large_file,
        filename: 'large_image.jpg',
        content_type: 'image/jpg'
      )

      expect(subject.update(profile_image: file_to_attach)).to be_falsey
      expect(subject.errors[:profile_image]).to include("size must be less than 5MB")

      large_file.close
      large_file.unlink  # Delete the temporary file
    end
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

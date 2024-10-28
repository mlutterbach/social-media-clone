require 'rails_helper'

RSpec.describe "User Registrations", type: :request do
  describe "PATCH /users" do
    let(:user) { User.create(username: 'Anything', password: 'secret', description: "Lorem ipsum", email: "user@email.com", name: "John Lennon") }

    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
    end

    it "updates the user's profile image" do
      file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_image.jpg'), 'image/jpeg')

      patch user_registration_path, params: { user: { profile_image: file, current_password: user.password } }

      expect(response).to redirect_to(root_path)
      user.reload
      expect(user.profile_image).to be_attached
    end
  end
end

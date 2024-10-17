require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      name: "Marcos Lutterbach",
      description: "Lorem Ipsum",
      email: "user100@email.com",
      username: "okNewUserName",
      password: "secret"
    }
  end

  let(:invalid_attributes) do
    {
      name: "",
      description: "Lorem",
      email: "",
      username: ""
    }
  end

  let(:user) { User.create!(valid_attributes) }
  let(:another_user) { User.create!(username: "AnotherUser", password: "secret", name: "Another Name", description: "Some person", email:"aperson@email.com") }
  let!(:tweet1) { user.tweets.create!(content: "First tweet") }
  let!(:tweet2) { user.tweets.create!(content: "Second tweet") }

  shared_examples "an authenticated user" do
    before { sign_in user }

    it "assigns the requested user as @user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "assigns the user's tweets as @tweets" do
      get :show, params: { id: user.id }
      expect(assigns(:tweets)).to match_array([tweet1, tweet2])
    end

    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #index" do
    context "when user is authenticated" do
      before do
        sign_in user
        get :index
      end

      it "assigns all users as @users" do
        expect(assigns(:users)).to eq([user])
      end
    end

    context "when user is not authenticated" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "when user is authenticated" do
      it_behaves_like "an authenticated user" do
        before { sign_in user }
      end
    end

    context "when user is not authenticated" do
      it "redirects to the login page" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #follow" do
    context "when user is authenticated" do
      before { sign_in user }

      it "user follows another user" do
        expect {
          post :follow, params: { id: another_user.id }
        }.to change { user.followed_users.count }.by(1)

        another_user.reload
        expect(another_user.followers_count).to eq(1)
        expect(response).to redirect_to(user_path(another_user))
        expect(flash[:notice]).to eq("You are now following #{another_user.name}.")
      end

      it "does not allow following the same user twice" do
        user.follow(another_user)
        expect {
          post :follow, params: { id: another_user.id }
        }.not_to change { user.followed_users.count }
      end
    end
  end

  describe "DELETE #unfollow" do
    context "when user is authenticated" do
      before { sign_in user }

      it "user unfollows another user" do
        user.follow(another_user)

        expect {
          delete :unfollow, params: { id: another_user.id }
        }.to change { user.followed_users.count }.by(-1)

        another_user.reload
        expect(another_user.followers_count).to eq(0)
        expect(response).to redirect_to(user_path(another_user))
        expect(flash[:notice]).to eq("You have unfollowed #{another_user.name}.")
      end

      it "does not allow unfollowing a user that is not followed" do
        # user is not following another_user
        expect {
          delete :unfollow, params: { id: another_user.id }
        }.not_to change { user.followed_users.count }
      end
    end

    context "when user is not authenticated" do
      it "redirects to the login page" do
        delete :unfollow, params: { id: another_user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

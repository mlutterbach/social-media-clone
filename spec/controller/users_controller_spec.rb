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
end

require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let(:valid_attributes) do
    {
      name: "Marcos Lutterbach",
      description: "Lorem Ipsum",
      email: "user100@email.com",
      username: "okNewUserName",
      password: "secret"
    }
  end

  let!(:user) { User.create!(valid_attributes)}
  let!(:tweet1) { user.tweets.create!(content: "First tweet") }
  let!(:tweet2) { user.tweets.create!(content: "Second tweet") }

  describe "GET #index" do
    context "when user is authenticated" do
      before { sign_in user }

      it "assigns all tweets as @tweets" do
        get :index
        expect(assigns(:tweets)).to match_array([tweet2, tweet1])
      end
    end
  end

  describe "GET #show" do
    context "when user is authenticated" do
      before { sign_in user }

      it "assigns tweet1 as @tweet, user as @user" do
        get :show, params: { id: tweet1.id, user_id: user.id}
        expect(assigns(:tweet)).to eq(tweet1)
        expect(assigns(:user)).to eq(user)
      end
    end
  end
end

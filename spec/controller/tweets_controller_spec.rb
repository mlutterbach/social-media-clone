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

      it "assigns tweet1 as @tweet, user as tweet1.user" do
        get :show, params: { id: tweet1.id, user_id: user.id}
        expect(assigns(:tweet)).to eq(tweet1)
        expect(tweet1.user).to eq(user)
      end
    end
  end

  describe 'POST #retweet' do
    before { sign_in user }
    it 'creates a new retweet' do
      expect {
        post :retweet, params: { id: tweet1.id }
      }.to change { Tweet.where(retweet_id: tweet1.id).count }.by(1)
    end

    it 'increments the retweet count of the original tweet1' do
      expect {
        post :retweet, params: { id: tweet1.id }
      }.to change { tweet1.reload.retweet_count }.by(1)
    end

    it 'redirects to the root path' do
      post :retweet, params: { id: tweet1.id }
      expect(response).to redirect_to(root_path)
    end

    it 'sets a notice flash message' do
      post :retweet, params: { id: tweet1.id }
      expect(flash[:notice]).to eq('Tweet retweeted successfully.')
    end
  end
end

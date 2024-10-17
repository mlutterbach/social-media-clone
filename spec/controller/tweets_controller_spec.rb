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

  describe "POST #create" do
    before { sign_in user }
    let(:tweet_params) { { tweet: { content: "New tweet!", user_id: user.id } } }
    let(:invalid_tweet_params) { { tweet: { content: "", user_id: user.id  } } }

    it "creates a new tweet" do
      expect{ post :create, params: tweet_params }.to change(Tweet, :count).by(1)
    end

    it 'redirects to the root path' do
      post :create, params: tweet_params
      expect(response).to redirect_to(root_path)
    end

    it 'sets a notice flash message' do
      post :create, params: tweet_params
      expect(flash[:notice]).to eq('Tweet created successfully.')
    end

    it 'does not save the tweet and sets a flash alert' do
      expect {
        post :create, params: invalid_tweet_params
      }.to_not change(Tweet, :count)
      expect(flash[:alert]).to eq("Content is too short (minimum is 2 characters)")
    end
  end

  describe 'GET #new' do
    before { sign_in user }
    it 'sets @tweet as a new tweet' do
      get :new
      expect(assigns(:tweet)).to be_a_new(Tweet)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
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

    it 'fails to retweet' do
      allow_any_instance_of(Tweet).to receive(:save).and_return(false)
      post :retweet, params: { id: tweet1.id }

      expect(flash[:alert]).to eq("Failed to retweet.")
      expect(response).to redirect_to(root_path)
      expect {
        post :retweet, params: { id: tweet1.id }
      }.to_not change(Tweet, :count)
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user }
    it 'deletes the tweet' do
      expect {
        delete :destroy, params: { id: tweet1.id }
      }.to change(Tweet, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end

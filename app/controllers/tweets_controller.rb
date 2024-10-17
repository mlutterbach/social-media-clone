class TweetsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :destroy, :retweet]
  before_action :authorize_user!, only: [:destroy]

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def show
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to root_path, notice: "Tweet created successfully."
    else
      redirect_to root_path, alert: @tweet.errors.full_messages.to_sentence
    end
  end

  def destroy
    retweets = Tweet.where(retweet_id: @tweet.id)
    retweets.destroy_all
    @tweet.destroy
    redirect_to root_path, status: :see_other
  end

  def retweet
    retweet = current_user.tweets.new(content: @tweet.content, retweet_id: @tweet.id)

    if retweet.save
      redirect_to root_path, notice: 'Tweet retweeted successfully.'
    else
      redirect_to root_path, alert: 'Failed to retweet.'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def authorize_user!
    unless @tweet.user == current_user
      redirect_to root_path, alert: "You are not authorized to delete this tweet."
    end
  end
end

class TweetsController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user, only: [:show, :new, :edit, :update, :destroy]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def about
  end

  def contact
  end

  def home
    @tweets = Tweet.all
  end

  def index
    @tweets = Tweet.all
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.retweet_count = 0
    @tweet.likes_count = 0
    if @tweet.save
      redirect_to user_tweets_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
    redirect_to user_tweets_path(@tweet)
  end

  def destroy
    @tweet.destroy
    redirect_to user_tweets_path(current_user), status: :see_other
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :reply_privacy, :location)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end

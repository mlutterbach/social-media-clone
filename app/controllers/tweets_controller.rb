class TweetsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]
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
    @user = User.find(params[:user_id])
    @tweet = @user.tweets.build(tweet_params)

    @tweet.retweet_count = 0
    @tweet.likes_count = 0
    if @tweet.save
      redirect_to root_path, notice: "Tweet created successfully."
    else
      redirect_to root_path, alert: @tweet.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: "Tweet updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to user_tweets_path(current_user), status: :see_other
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
    params.require(:tweet).permit(:content, :reply_privacy, :location)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def authorize_user!
    unless @tweet.user == current_user
      redirect_to root_path, alert: "You are not authorized to delete this tweet."
    end
  end
end

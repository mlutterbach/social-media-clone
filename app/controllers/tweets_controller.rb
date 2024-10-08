class TweetsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: [:show, :new, :edit, :update, :destroy]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def show
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

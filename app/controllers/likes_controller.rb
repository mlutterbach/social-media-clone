class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = current_user.likes.build(tweet: @tweet)

    if @like.save
      @tweet.increment!(:likes_count)
      redirect_to root_path, notice: "Liked the tweet!"
    else
      redirect_to root_path, notice: "Unable to like the tweet"
    end
  end

  def destroy
    @like = current_user.likes.find_by(tweet_id: params[:tweet_id])
    if @like.destroy
      @tweet = Tweet.find(params[:tweet_id])
      @tweet.decrement!(:likes_count)
      redirect_to root_path, notice: "Unliked the tweet."
    else
      redirect_to root_path, alert: "Unable to unlike the tweet."
    end
  end
end

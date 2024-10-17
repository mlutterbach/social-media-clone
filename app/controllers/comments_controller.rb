class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]
  before_action :set_tweet

  def create
    @comment = @tweet.comments.new(comments_params)
    @comment.user = current_user
    if @comment.save
      redirect_to tweet_path(@tweet), notice: "Comment created successfully"
    else
      redirect_to tweet_path(@tweet), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    redirect_to tweet_path(@tweet)
  end

  private

  def comments_params
    params.require(:comment).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def authorize_user!
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to root_path, alert: "You are not authorized to delete this comment."
    end
  end
end

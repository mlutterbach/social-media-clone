class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new(comments_params)
    @comment.user = current_user
    if @comment.save
      redirect_to tweet_path(@tweet), notice: "Comment created successfully"
    else
      redirect_to root_path, alert: @tweet.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_tweets_path(current_user)
  end

  private

  def comments_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    unless @comment.user == current_user
      redirect_to root_path, alert: "You are not authorized to delete this comment."
    end
  end
end

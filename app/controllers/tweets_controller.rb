class TweetsController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

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

  def new
    @tweet = Tweet.new
  end
  
end

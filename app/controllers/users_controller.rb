class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end
end

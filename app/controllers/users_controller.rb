class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user, only: [:show, :follow, :unfollow]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc)
  end

  def follow
    current_user.follow(@user)
    redirect_to user_path(@user), notice: "You are now following #{@user.name}."
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to user_path(@user), notice: "You have unfollowed #{@user.name}."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

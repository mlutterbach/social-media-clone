class UsersController < ApplicationController
  def about
  end

  def contact
  end

  def home
    @users = User.all
  end
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
end

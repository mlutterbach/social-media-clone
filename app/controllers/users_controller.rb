class UsersController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
end

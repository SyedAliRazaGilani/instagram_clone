# frozen_string_literal: true

# User Controller
class UsersController < ApplicationController
  def index
    @users = User.confirmed
  end
  
  def show
    @user = User.includes(:posts, :followers).find(params[:id])
  end

  def search
    @users = User.search("%#{params[:search].sub('%', '-')}%")
  end

  def edit; end

  def requests
    @followers = current_user.followers
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = 'updated info'
    else
      flash[:alert] = 'could not update information'
    end
    redirect_to current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :mobilenumber, :public)
  end
end

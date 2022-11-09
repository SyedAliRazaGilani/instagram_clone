# frozen_string_literal: true

# followers controller
class FollowersController < ApplicationController
  def create
    @follower = Follower.new(follower_params)
    authorize @follower

    if @follower.save
      flash[:success] = 'Follow Request Accepted Successfully.'
    else
      flash[:alert] = 'Already Following'
    end
    redirect_to current_user
  end

  def destroy
    follower = Follower.find(params[:id])
    authorize follower

    if follower.destroy
      flash[:success] = 'Request Canceled'
    else
      flash[:alert] = 'can not cancel request'
    end
    redirect_to current_user
  end

  private

  def follower_params
    params.permit(:user_id, :follower_id)
  end
end

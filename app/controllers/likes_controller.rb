# frozen_string_literal: true

# Likes Controller
class LikesController < ApplicationController
  before_action :find_post

  def create
    like = current_user.likes.new(like_params)
    authorize like

    like.save
  end

  def destroy
    like = Like.find(params[:id])
    authorize like

    like.destroy
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
    authorize @post, policy: PostPolicy
  end

  def like_params
    params.permit(:post_id)
  end
end

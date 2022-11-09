# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post was successfully created.'
    else
      flash[:alert] = 'Post was not created.'
    end
    redirect_to current_user
  end

  def edit; end

  def update
    flash[:success] = 'Post was successfully updated.' if @post.update(post_params)

    redirect_to post_path(@post.id)
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post was successfully destroyed.'
    else
      flash[:alert] = 'Post was not destroyed.'
    end
    redirect_to current_user
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.permit(:caption, :user_id, images: [])
  end
end

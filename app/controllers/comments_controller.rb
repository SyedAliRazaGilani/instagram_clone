# frozen_string_literal: true

# comments controller
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def edit; end

  def create
    comment = Comment.new(comment_params)
    authorize comment
    if comment.save
      flash[:success] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment can not be blank. '
    end
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'Comment was successfully updated.'
    else
      flash[:alert] = 'Comment can not be updated.'
    end
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment was destroyed.'
    else
      flash[:alert] = 'Comment can not be destroyed.'
    end
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end

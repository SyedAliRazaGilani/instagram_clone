# frozen_string_literal: true

# Stories Controller
class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy]

  def index
    @stories = Story.all
    authorize Story
  end

  def new
    @story = Story.new
    authorize @story
  end

  def create
    story = Story.new(story_params)
    authorize story
    if story.save
      flash[:success] = 'Story was successfully created.'
    else
      flash[:alert] = 'Story was not created'
    end
    redirect_to user_stories_path
  end

  def edit; end

  def update
    if @story.update(story_params)
      flash[:success] = 'Story was successfully updated.'
    else
      flash[:alert] = 'Story was not updated'
    end
    redirect_to user_stories_path
  end

  def destroy
    if @story.destroy
      flash[:alert] = 'Story was successfully deleted.'
    else
      flash[:success] = 'Story was not deleted'
    end
    redirect_to user_stories_path
  end

  private

  def set_story
    @story = Story.find(params[:id])
    authorize @story
  end

  def story_params
    params.require(:story).permit(:caption, :user_id, :image)
  end
end

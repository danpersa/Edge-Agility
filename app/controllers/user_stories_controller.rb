class UserStoriesController < ApplicationController

  respond_to :json, :html

  def index
    @user_stories = UserStory.all
    respond_with @user_stories, :handler => [:rabl]
  end

  def show
    @user_story = UserStory.find(params[:id])
  end

  def create
    @user_story = UserStory.new(params[:user_story])
    respond_to do |format|
      if @user_story.save
        format.json { respond_with @user_story, :responder => AppResponder }
      else
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user_story = UserStory.find(params[:id])
    respond_to do |format|
      if @user_story.update_attributes(params[:user_story])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @user_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_story = UserStory.find(params[:id])
    @user_story.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

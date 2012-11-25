class UserStoriesController < ApplicationController
  before_filter :authenticate

  respond_to :json, :html

  def index
    if (params[:iteration_id].nil?)
      @user_stories = current_project.user_stories
    else
      if (params[:status].nil?)
        @user_stories = UserStory.where(:iteration_id => params[:iteration_id])
      else
        @user_stories = UserStory.where(:iteration_id => params[:iteration_id], :status => params[:status].to_i)
      end
    end
    respond_with @user_stories, :handler => [:rabl]
  end

  def show
    @user_story = UserStory.find(params[:id])
  end

  def create
    @user_story = UserStory.new(params[:user_story])
    @user_story.status = 0
    @user_story.points = 0
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

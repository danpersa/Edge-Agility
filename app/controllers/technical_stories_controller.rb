class TechnicalStoriesController < ApplicationController
  before_filter :authenticate
  
  respond_to :json, :html

  def index
    @technical_stories = TechnicalStory.all
    respond_with @technical_stories, :handler => [:rabl]
  end

  def show
    @technical_story = TechnicalStory.find(params[:id])
  end

  def create
    @technical_story = TechnicalStory.new(params[:technical_story])
    respond_to do |format|
      if @technical_story.save
        format.json { respond_with @technical_story, :responder => AppResponder }
      else
        format.json { render json: @technical_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @technical_story = TechnicalStory.find(params[:id])
    respond_to do |format|
      if @technical_story.update_attributes(params[:technical_story])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @technical_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @technical_story = TechnicalStory.find(params[:id])
    @technical_story.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

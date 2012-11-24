class ScenariosController < ApplicationController
  before_filter :authenticate
  
  respond_to :json, :html

  def index
    @scenarios = Scenario.all
    respond_with @scenarios, :handler => [:rabl]
  end

  def show
    @scenario = Scenario.find(params[:id])
  end

  def create
    @scenario = Scenario.new(params[:scenario])
    respond_to do |format|
      if @scenario.save
        format.json { respond_with @scenario, :responder => AppResponder }
      else
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @scenario = Scenario.find(params[:id])
    respond_to do |format|
      if @scenario.update_attributes(params[:scenario])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

class IterationsController < ApplicationController
  before_filter :authenticate

  respond_to :json, :html

  def index
    @iterations = Iteration.all
    respond_with @iterations, :handler => [:rabl]
  end

  def show
    @iteration = Iteration.find(params[:id])
  end

  def create
    @iteration = Iteration.new(params[:iteration])
    respond_to do |format|
      if @iteration.save
        format.json { respond_with @iteration, :responder => AppResponder }
      else
        format.json { render json: @iteration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @iteration = Iteration.find(params[:id])
    respond_to do |format|
      if @iteration.update_attributes(params[:iteration])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @iteration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @iteration = Iteration.find(params[:id])
    @iteration.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

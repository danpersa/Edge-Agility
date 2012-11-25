class IterationsController < ApplicationController
  before_filter :authenticate

  respond_to :json, :html

  def index
    if (params[:project_id].nil?)
      @iterations = Iteration.all
    else
      @iterations = Project.where(_id: params[:project_id]).first.iterations
    end
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

  def backlog_iteration
    Project.find(params[:project_id]).iterations.each do |iteration|
      if (iteration.name == 'Backlog')
        @iteration = iteration
      end  
    end
    respond_with @iteration, :handler => [:rabl]
  end
end

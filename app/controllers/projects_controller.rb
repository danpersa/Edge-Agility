class ProjectsController < ApplicationController
  respond_to :json, :html

  def index
    @projects = Project.all
    respond_with @projects, :handler => [:rabl]
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        format.json { respond_with @project, :responder => AppResponder }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end

end

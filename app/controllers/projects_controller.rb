class ProjectsController < ApplicationController
  before_filter :authenticate
  
  respond_to :json, :html

  def index
    @projects = current_user.projects
    respond_with @projects, :handler => [:rabl]
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        current_user.join @project
        iteration = Iteration.create! :name => "Backlog",
                      :start_date => Date.new,
                      :end_date => Date.new,
                      :project_id => @project.id
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

  def set_as_current
    session[:current_project_id] = params[:id]
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

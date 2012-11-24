class PrototypesController < ApplicationController
  before_filter :authenticate
  
  respond_to :json, :html

  def index
    @prototypes = Prototype.all
    respond_with @prototypes, :handler => [:rabl]
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def create
    @prototype = Prototype.new(params[:prototype])
    respond_to do |format|
      if @prototype.save
        format.json { respond_with @prototype, :responder => AppResponder }
      else
        format.json { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    respond_to do |format|
      if @prototype.update_attributes(params[:prototype])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end

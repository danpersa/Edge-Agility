class UsersController < ApplicationController
  before_filter :authenticate
  
  respond_to :json, :html

  def index
    @users = User.all
    respond_with @users, :handler => [:rabl]
  end

  def show
    @user = user.find(params[:id])
  end

  def destroy
    @user = user.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end

  def show_current_user
    @user = current_user
    respond_with @user, :handler => [:rabl]
  end
end

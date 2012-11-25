module SessionsHelper

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.where(:id => user_id).first
    if @current_user.nil?
        return nil
    end
    return @current_user
  end

  def current_project
    current_project_id = session[:current_project_id]

    @current_project ||= Project.where(:_id => current_project_id).first
    if @current_project.nil?
      return nil
    end
    return @current_project  
  end

  def signed_in?
    !current_user.nil?
  end

  def authenticate
    deny_access("Please sign in to access this page.") unless signed_in?
  end

  def deny_access(message)
    respond_to do |format|
      format.html { redirect_to '/auth/github'}
      format.json { render json: {error: message}, status: :unauthorized }
    end
  end
end

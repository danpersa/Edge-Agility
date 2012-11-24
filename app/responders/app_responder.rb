class AppResponder < ActionController::Responder
  
  def to_format
    return render unless resource.respond_to?(:"to_#{format}")

    if get?
      display resource
    elsif has_errors?
      controller.response.status = :unprocessable_entity
      display_errors
    elsif post?
      controller.response.status = :created
      default_render
    else
      head :ok
    end
  end
end


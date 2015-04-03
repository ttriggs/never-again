module AdminHelper
  def authorize_user
    unless user_signed_in? && current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end

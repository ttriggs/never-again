class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_permitted_parameters, if: :devise_controller?

  protected

  include AdminHelper

  def devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:sign_up) << :profile_photo
    devise_parameter_sanitizer.for(:account_update) << :profile_photo
  end
end

# class ApplicationController < ActionController::Base
#   # Prevent CSRF attacks by raising an exception.
#   # For APIs, you may want to use :null_session instead.
#   protect_from_forgery with: :exception
# end

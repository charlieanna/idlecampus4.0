#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
 
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :rolable_type)}
  end
end
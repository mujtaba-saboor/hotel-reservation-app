class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:new, :create]
  protect_from_forgery with: :exception

  include HotelsHelper
  include RoomsHelper

  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "log in to access this page"
      redirect_to root_url
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end

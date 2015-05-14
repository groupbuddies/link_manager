require 'trailblazer/operation/controller'

class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  def current_user
    @current_user ||= User::Store.fetch(cookies[:auth_token])
  end
  helper_method :current_user

  def require_login
    unless current_user.signed_in?
      deny_access
    end
  end

  def deny_access
    respond_to do |format|
      format.any(:js, :json, :xml) { head :unauthorized }
      format.any { redirect_to root_path }
    end
  end
end

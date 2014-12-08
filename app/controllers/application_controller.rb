class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :instantiate_current_user

  def index
    @message = "Who controls it?"
  end

  private
  def instantiate_current_user
    @current_user ||= session[:current_user_id] &&
      Entity.find_by(id: session[:current_user_id])
  end
end

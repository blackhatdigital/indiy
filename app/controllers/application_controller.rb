class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :logged_out?, :cents_to_dollars


  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def logged_out?
    current_user.nil?
  end

  def logged_in_only
    redirect_to root_path unless logged_in?
  end

  def logged_out_only
    redirect_to user_path(current_user) unless logged_out?
  end

  def cents_to_dollars(cents)
    "$#{cents.to_i/100.0}"
  end
end

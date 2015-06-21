#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # Query: Returns the current user based on the user_id in session
  #
  # @return [Workout::Member|Workout::UnknownUser]
  #
  def current_user
    @_current_user ||= User.current_user(session[:user_id])
  end
  helper_method :current_user

  # Query: Returns true if current_user has an id defined
  #
  # @return [Boolean]
  #
  def logged_in?
    current_user.id.present?
  end
  helper_method :logged_in?

  def current_user?(user)
    return false if user.nil?
    return false if user.is_a?(User::NullUser)
    current_user == user
  end
  helper_method :current_user?
end

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :must_sign_in
  helper_method :must_be_admin

  def must_sign_in
    redirect_to login_path, notice: 'You must sign in to do that' if current_user.nil?
  end

  def must_be_admin
    redirect_to login_path, notice: 'Only admin can do that' unless current_user&.is_admin?
  end

  around_action :set_time_zone

  def current_user
    return nil if session[:user_id].nil?

    User.find_by id: session[:user_id]
  end

  def set_time_zone(&block)
    Time.use_zone("Helsinki", &block)
  end
end

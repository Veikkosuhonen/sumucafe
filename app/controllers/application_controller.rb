class ApplicationController < ActionController::Base
  helper_method :current_user

  around_action :set_time_zone

  def current_user
    return nil if session[:user_id].nil?

    User.find_by id: session[:user_id]
  end

  def set_time_zone(&block)
    Time.use_zone("Helsinki", &block)
  end
end

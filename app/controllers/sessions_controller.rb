# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      auth_token = user.auth_token

      if auth_token.nil?
        user.generate_token(:auth_token)
        user.save
        auth_token = user.auth_token
      end

      cookies.permanent[:auth_token] = auth_token

      redirect_to root_path, notice: "Welcome back!"
    else
      redirect_to login_path, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    cookies.delete :auth_token
    redirect_to :root
  end
end

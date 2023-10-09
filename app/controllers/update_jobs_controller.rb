# frozen_string_literal: true

class UpdateJobsController < ApplicationController
  before_action :must_be_admin

  def new
  end

  def create
    if Rails.env.production?
      UpdateUnicafeMenuJob.perform_async
    else
      UpdateUnicafeMenuMockJob.perform
    end
    redirect_to root_path, notice: "Update job created"
  end
end

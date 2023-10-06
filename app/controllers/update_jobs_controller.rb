# frozen_string_literal: true

class UpdateJobsController < ApplicationController
  before_action :must_be_admin

  def new
  end

  def create
    UpdateUnicafeMenuJob.perform_async
    redirect_to root_path, notice: "Update job created"
  end
end

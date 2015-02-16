class Admin::SubmissionsController < ApplicationController

  before_filter :check_admin

  def reviews
    @submission = Submission.find(params[:id])
    respond_to do |format|
      format.pdf { render pdf: "Review for #{@submission.submission_title}", layout: 'pdf'}
    end
  end

  private

  def check_admin
    redirect_to projects_path unless is_admin?
  end

end

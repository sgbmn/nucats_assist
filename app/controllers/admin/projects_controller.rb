class Admin::ProjectsController < ApplicationController

  def reviews
    @project = Project.find(params[:id])
    respond_to do |format|
      response.headers['Content-Disposition'] = 'attachment; filename="reviews.xls"'
      format.xls { render :reviews, format: :xhtml }
    end
  end

end

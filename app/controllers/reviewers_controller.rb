# -*- coding: utf-8 -*-

##
# Controller for Reviewers model
class ReviewersController < ApplicationController
  # GET /reviewers
  # GET /reviewers.xml
  before_filter :set_project

  def index
    set_session_project(params[:project_id]) unless params[:project_id].blank?
    @assigned_submission_reviews = current_user_session.submission_reviews.this_project(current_project.id)
    respond_to do |format|
      format.html { render action: 'index' } # index.html.erb
      format.xml  { render xml: @reviewers }
    end
  end

  def index_with_files
    @include_files = true
    index
  end

  def complete_listing
    set_session_project(params[:project_id]) unless params[:project_id].blank?
    @assigned_submission_reviews = current_user_session.submission_reviews.this_project(current_project.id)
    @submission_reviews = current_project.submission_reviews.all if can_read?(@assigned_submission_reviews)
    @submission_reviews = current_project.submission_reviews.all
    respond_to do |format|
      format.html { render action: 'index' } # index.html.erb
      format.xml  { render xml: @reviewers }
    end
  end

  def complete_listing_with_files
    set_session_project(params[:project_id]) unless params[:project_id].blank?
    @include_files = true
    @speed_display = true
    @assigned_submission_reviews = current_user_session.submission_reviews.this_project(current_project.id)
    @submission_reviews = current_project.submission_reviews.all if can_read?(@assigned_submission_reviews)
    respond_to do |format|
      format.html { render action: 'index' } # index.html.erb
      format.xml  { render xml: @reviewers }
    end
  end

  def can_read?(assigned_submission_reviews)
    show_to_reviewers = current_project.show_composite_scores_to_reviewers || current_project.show_review_summaries_to_reviewers
    has_read_all?(current_program) || (assigned_submission_reviews.length > 0 && show_to_reviewers)
  end
  private :can_read?

  def all_reviews
    projects = Project.active(Date.today)
    @submission_reviews = current_user_session.submission_reviews.active(projects.map(&:id))
    @submission_reviews_title = 'Historical reviews across all competitions'
    @include_competition = true
    respond_to do |format|
      format.html { render :index }# index.html.erb
      format.xml  { render xml: @reviewers }
    end
  end

  def cannot_save_changes_error_message
    'Sorry - You cannot save changes to this review!<br/>The review date for this competition is over.<br/>' +
    'Please contact the administrator for the competition if you need to submit additional reviews!'
  end
  private :cannot_save_changes_error_message

  # GET /reviewers/1/edit
  def edit
    @submission_review = SubmissionReview.find(params[:id])
    if @submission_review.submission.project.review_end_date < Date.today && is_admin?(current_program)
      flash[:errors] = cannot_save_changes_error_message
      render :edit
    elsif @submission_review.submission.project.review_end_date < Date.today
      flash[:errors] = cannot_save_changes_error_message
      redirect_to project_reviewers_url(current_project)
    elsif is_admin?(current_program) || @submission_review.reviewer_id == current_user_session.id
      respond_to do |format|
        format.html # edit.html.erb
        format.xml  { render xml: @reviewer }
      end
    else
      if current_project.blank?
        redirect_to projects_path
      else
        redirect_to project_path(current_project.id)
      end
    end
  end

  # PUT /reviewers/1
  # PUT /reviewers/1.xml
  def update
    @submission_review = SubmissionReview.find(params[:id])
    if can_update_submission_review?(@submission_review) || is_admin?(@submission_review.submission.project.program)
      respond_to do |format|
        if @submission_review.update_attributes(params[:submission_review])
          flash[:notice] = 'Review was successfully updated.'
          format.html { redirect_to(project_reviewers_url(current_project)) }
          format.xml  { head :ok }
        else
          format.html { render action: 'edit' }
          format.xml  { render xml: @reviewer.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = 'You do not have update privileges or this review is past the edit cutoff.'
      redirect_to(project_reviewers_url(current_project))
    end
  end

  def update_item
    @submission_review = SubmissionReview.find(params[:id])
    if can_update_submission_review?(@submission_review) || is_admin?(@submission_review.submission.project.program)
      respond_to do |format|
        if @submission_review.update_attributes(params[:submission_review])
          flash[:notice] = 'Review was successfully updated.'
          format.html { redirect_to(project_reviewers_url(current_program)) }
          format.xml  { head :ok }
        else
          format.html { render action: 'edit' }
          format.xml  { render xml: @reviewer.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = 'You do not have update privileges or this review is past the edit cutoff.'
      redirect_to project_reviewers_url(current_program)
    end
  end

  def can_update_submission_review?(submission_review)
    submission_review.reviewer_id == current_user_session.id &&
    submission_review.submission.project.review_end_date >= (Date.today)
  end
  private :can_update_submission_review?

  # DELETE /reviewers/1
  # DELETE /reviewers/1.xml
  def destroy
    if is_admin?
      @reviewer = Reviewer.find(params[:id])
      @reviewer.destroy if is_admin?
    else
      flash[:notice] = 'You do not have delete priveleges.'
    end
    respond_to do |format|
      format.html { redirect_to(project_reviewers_url(current_program)) }
      format.xml  { head :ok }
    end
  end

  def set_project
    unless params[:project_id].blank?
      @project = Project.find(params[:project_id])
      set_current_project(@project)
    end
  end
  private :set_project
end

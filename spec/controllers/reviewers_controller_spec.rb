# -*- coding: utf-8 -*-
require 'spec_helper'

describe ReviewersController do

  context 'with a logged in user' do
    before do
      login(user_login)
    end

    describe 'GET index' do
      it 'renders the page' do
        get :index
        response.should be_success
        assigns[:assigned_submission_reviews].should eq []
      end
    end

    describe 'GET edit' do
      let(:review) { FactoryGirl.create(:submission_review) }
      it 'redirects to projects_path' do
        get :edit, id: review.id, project_id: review.project.id
        response.should redirect_to(project_path(review.project))
      end
    end

  end
  ##
  # TODO: these specs pass when running alone when run as a suite
  #       they fail. figure out how to reset session for specs
  ##
  # describe 'PUT update' do
  #   let(:review) { FactoryGirl.create(:submission_review) }
  #   it 'redirects to project_reviewers_path' do
  #     put :update, :id => review, :reviewer => {}
  #     response.should redirect_to(project_reviewers_path(review.submission.project))
  #   end
  # end
  #
  # describe 'DELETE destroy' do
  #   it 'redirects to project_reviewers_path' do
  #     delete :destroy, :id => review
  #     response.should redirect_to(project_reviewers_path(review.submission.project.program))
  #   end
  # end

end
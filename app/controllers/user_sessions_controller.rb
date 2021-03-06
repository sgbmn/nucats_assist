# -*- coding: utf-8 -*-
#
# Controller class to help with logging in and out of the application.
#
# /auth/:provider/callback gets routed to user_sessions#create
# /auth/failure gets routed to user_sessions#failure
# /signout gets routed to user_sessions#destroy
# @see routes.rb
class UserSessionsController < ApplicationController
  before_filter :authenticate_user, only: [:destroy]
  skip_before_filter :check_cookie, only: [:create, :failure]

  respond_to :html

  # omniauth callback method
  def create
    omniauth = env['omniauth.auth']
    Rails.logger.info("~~~ omniauth = #{omniauth}")
    user = User.find_or_create_from_omniauth(omniauth)
    Rails.logger.info("~~~ user = #{user}")
    set_session_attributes(user, omniauth)
    check_session
    flash[:notice] = 'You have successfully logged in!'
    redirect_to request.env['omniauth.origin'] || projects_path
  end

  # Omniauth failure callback
  def failure
    flash[:errors] = params[:message].to_s.titleize
    redirect_to welcome_path
  end

  # signout - Clear our rack session user_info
  def destroy
    clear_session_attributes
    flash[:errors] = 'You have successfully signed out!'
    redirect_to "#{ENV['OAUTH_CLIENT_PROVIDER_URL']}/people/sign_out?client_id=#{ENV['OAUTH_CLIENT_APP_ID']}"
  end

end

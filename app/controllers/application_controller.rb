class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  layout :user_layout

protected
  def user_layout
    if current_user
      "application_login"
    else
      "application_logout"
    end
  end

  def set_locale
    I18n.locale = params[:current_locale]
  end

  def validate_access_token
    if current_user
      begin
        logger.debug "hahaha"
        current_user.nuvo.me
        logger.debug "hahaha2"
      rescue
        logger.debug "hahaha3"
        @auth_path = "/auth/nuvo?current_locale=#{I18n.locale}&rp=#{request.fullpath}"
        if request.xhr?
          logger.debug "hahaha4"
          respond_to do |format|
            format.js { render "application/validate_access_token" }
          end
        else
          logger.debug "hahaha5"
          redirect_to @auth_path
        end
      end
    end
  end

  def default_url_options(options = {})
    {:current_locale => I18n.locale}
  end

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
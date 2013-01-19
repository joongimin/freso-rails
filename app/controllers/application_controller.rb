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
        current_user.nuvo.me
      rescue
        @auth_path = "/auth/nuvo?current_locale=#{I18n.locale}&rp=#{request.fullpath}"
        if request.xhr?
          respond_to do |format|
            format.js { render "application/validate_access_token" }
          end
        else
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
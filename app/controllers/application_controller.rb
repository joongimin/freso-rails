class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :renew_access_token
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

  def renew_access_token
    if !request.xhr? && current_user && current_user.nuvo_access_token_expires_at < Time.now
      redirect_to "/auth/nuvo?current_locale=#{I18n.locale}"
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
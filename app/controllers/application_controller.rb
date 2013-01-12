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

  def default_url_options(options = {})
    {:current_locale => I18n.locale}
  end
end
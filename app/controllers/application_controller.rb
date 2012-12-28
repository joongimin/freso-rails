class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:current_locale]
  end

  def default_url_options(options = {})
    {:current_locale => I18n.locale}
  end
end

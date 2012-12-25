class HomeController < ApplicationController
  def index
  end
  def no_locale_matched
    if !current_user.nil?
      I18n.locale = current_user.locale
    else
      if !request.location.nil? && request.location.country_code == "KR"
        I18n.locale = :"ko-KR"
      else
        I18n.locale = :"en-US"
      end
    end

    redirect_to "/#{I18n.locale}#{request.path}#{"?" + request.query_parameters.to_query unless request.query_parameters.empty?}"
  end
end
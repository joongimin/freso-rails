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

  def no_route_matched
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.any  { head :not_found }
    end
  end
end
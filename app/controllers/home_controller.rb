class HomeController < ApplicationController
  def index
    if current_user
      if current_user.brands.count == 0
        respond_to do |format|
          format.html { redirect_to new_brand_path }
          format.js { @next_path = "brands/new" }
        end
      elsif current_user.brands.count == 1
        brand = current_user.brands.first
        if brand.current_layout.nil?
          respond_to do |format|
            format.html { redirect_to select_layout_brand_path(brand) }
            format.js { @next_path = "brands/select_layout" }
          end
        else
          respond_to do |format|
            format.js { render :logged_in }
            format.html { render :logged_in }
          end
        end
      end
    else
      respond_to do |format|
        format.html { render :index }
      end
    end
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
      format.html { render :file => "#{Rails.root}/public/404", :status => :not_found }
      format.any  { head :not_found }
    end
  end
end
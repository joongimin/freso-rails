class HomeController < ApplicationController
  before_filter :validate_access_token, :only => [:index]

  def index
    if current_user
      if current_user.brands.count == 0
        @next_path = new_brand_path
      else
        @brand = current_user.brands.first
        if @brand.current_layout.layout_template.nil?
          @next_path = select_layout_brand_path(@brand)
        else
          if !@brand.current_layout.layout_option.nil?
            @next_path = customize_tutorial_brand_path(@brand)
          else
            @next_path = menu_brand_path(@brand)
          end
        end
      end

      respond_to do |format|
        format.html { redirect_to @next_path }
        format.js
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
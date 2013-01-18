class BrandsController < ApplicationController
  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new
    @brand = Brand.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @brand = Brand.new(params[:brand].merge(:user_id => current_user.id))
    if @brand.save
      @layout = Layout.create(:brand_id => @brand.id)
      respond_to do |format|
        format.js
        #format.json { render :json => :select_layout }
      end
    else
      render :action => 'new'
    end
  end

  def select_layout
    @brand = Brand.find(params[:id])
    @layout = @brand.layouts.last
    if params.include?(:page_number)
      @total_count = params[:total_count].to_i
      @current_page = params[:page_number].to_i
      @layout_templates = LayoutTemplate.with_translations(I18n.locale).
          offset((params[:page_number].to_i - 1) * LAYOUT_TEMPLATES_PER_PAGE_COUNT).
          limit(LAYOUT_TEMPLATES_PER_PAGE_COUNT)
      respond_to do |format|
        format.js { render "layout_templates/layout_templates_list" }
      end
    end
  end

  def update_layout
    @brand = Brand.find(params[:id])
    @layout = @brand.layouts.last
    #@layout = Layout.find(params[:id])
    if @layout.update_attributes(params[:layout])
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update_attributes(params[:brand])
      redirect_to @brand, :notice  => "Successfully updated brand."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_url, :notice => "Successfully destroyed brand."
  end

  def select_layout
  end

  def customize
  end
end

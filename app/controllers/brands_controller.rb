class BrandsController < ApplicationController
  before_filter :validate_access_token, :only => [:new, :edit]

  def index
    @brands = Brand.all
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    @brand = Brand.new(params[:brand].merge(:user_id => current_user.id))
    if @brand.save
      respond_to do |format|
        format.js { render :slide_to_select_layout }
      end
    else
      render :action => 'new'
    end
  end

  def select_layout
    @brand = Brand.find(params[:id])
    if params[:prev] == "true"
      respond_to do |format|
        format.js { render :slide_to_select_layout }
      end
    end
  end

  def update_layout
    @brand = Brand.find(params[:id])
    if @brand.current_layout.update_attributes(params[:layout])
      respond_to do |format|
        format.js { render :slide_to_customize_tutorial }
      end
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update_attributes(params[:brand])
      respond_to do |format|
        format.js { render :slide_to_select_layout }
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to brands_url, :notice => "Successfully destroyed brand."
  end

  def customize_tutorial
    @brand = Brand.find(params[:id])
  end

  def customize
  end

  def menu
    @brand = Brand.find(params[:id])
  end

private
  def layout_templates
    if params[:page].nil? && !@brand.current_layout.layout_template.nil?
      params[:page] = (LayoutTemplate.where("? >= id", @brand.current_layout.layout_template_id).count.to_f / 8).ceil
    end
    @layout_templates ||= LayoutTemplate.page(params[:page]).per(8)
  end
  helper_method :layout_templates
end

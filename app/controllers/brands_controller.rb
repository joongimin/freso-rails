class BrandsController < ApplicationController
  before_filter :validate_access_token, :only => [:new, :edit]

  def index
    @brands = Brand.all
  end

  def show
    @brand = current_resource
    render :show, :layout => false
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
        format.js { render :select_layout }
      end
    else
      render :action => 'new'
    end
  end

  def select_layout
    @brand = current_resource
    if params[:layout_template].nil?
      respond_to do |format|
        format.js { render :select_layout }
        format.html
      end
    end
  end

  def update_layout
    @brand = current_resource
    if @brand.current_layout.update_attributes(params[:layout])
      respond_to do |format|
        format.js { render :customize_tutorial }
      end
    end
  end

  def edit
    @brand = current_resource
  end

  def update
    @brand = current_resource
    if @brand.update_attributes(params[:brand])
      respond_to do |format|
        format.js { render :select_layout }
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @brand = current_resource
    @brand.destroy
    redirect_to brands_url, :notice => "Successfully destroyed brand."
  end

  def customize_tutorial
    @brand = current_resource
  end

  def customize
    @brand = current_resource
    @no_topbar = true
  end

  def menu
    @brand = current_resource
  end

private
  def layout_templates
    if params[:page].nil? && !@brand.current_layout.layout_template.nil?
      params[:page] = (LayoutTemplate.where("? >= id", @brand.current_layout.layout_template_id).count.to_f / 8).ceil
    end
    @layout_templates ||= LayoutTemplate.page(params[:page]).per(8)
  end
  helper_method :layout_templates

  def current_resource
    @current_resource ||= Brand.find(params[:id]) if params[:id]
  end
end

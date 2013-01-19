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
      @layout = Layout.create(:brand_id => @brand.id)
      respond_to do |format|
        format.js { render :slide_to_select_layout }
      end
    else
      render :action => 'new'
    end
  end

  def select_layout
  end

  def update_layout
    @brand = Brand.find(params[:id])
    @layout = @brand.layouts.last
    #@layout = Layout.find(params[:id])
    if @layout.update_attributes(params[:layout])
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
    @layout = @brand.layouts.last
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
  end

  def customize
  end

  def slide_back_to_select_layout
    @brand = Brand.find(params[:id])
    @layout = @brand.layouts.last
    respond_to do |format|
      format.js
    end
  end
end

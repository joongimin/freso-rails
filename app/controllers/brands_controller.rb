class BrandsController < ApplicationController
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
        format.js
        #format.json { render :json => :select_layout }
      end
    else
      render :action => 'new'
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

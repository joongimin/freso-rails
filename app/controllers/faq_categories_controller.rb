class FaqCategoriesController < ApplicationController
  def index
    @faq_categories = FaqCategories.all
  end

  def show
    @faq_categories = FaqCategories.find(params[:id])
  end

  def new
    @faq_categories = FaqCategories.new
  end

  def create
    @faq_categories = FaqCategories.new(params[:faq_categories])
    if @faq_categories.save
      redirect_to @faq_categories, :notice => "Successfully created faq categories."
    else
      render :action => 'new'
    end
  end

  def edit
    @faq_categories = FaqCategories.find(params[:id])
  end

  def update
    @faq_categories = FaqCategories.find(params[:id])
    if @faq_categories.update_attributes(params[:faq_categories])
      redirect_to @faq_categories, :notice  => "Successfully updated faq categories."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @faq_categories = FaqCategories.find(params[:id])
    @faq_categories.destroy
    redirect_to faq_categories_url, :notice => "Successfully destroyed faq categories."
  end
end

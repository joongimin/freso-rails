class LayoutTemplatesController < ApplicationController
  before_filter :set_content_type

private
  def set_content_type
    @content_type = :admin
  end

public
  # GET /layout_templates
  # GET /layout_templates.json
  LAYOUT_TEMPLATES_PER_PAGE_COUNT = 8
  def index
    @layout_templates = LayoutTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @layout_templates }
    end
  end

  # GET /layout_templates/1
  # GET /layout_templates/1.json
  def show
    @layout_template = LayoutTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @layout_template }
    end
  end

  # GET /layout_templates/new
  # GET /layout_templates/new.json
  def new
    @layout_template = LayoutTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @layout_template }
    end
  end

  # GET /layout_templates/1/edit
  def edit
    @layout_template = LayoutTemplate.find(params[:id])
  end

  # POST /layout_templates
  # POST /layout_templates.json
  def create
    @layout_template = LayoutTemplate.new(params[:layout_template])

    respond_to do |format|
      if @layout_template.save
        format.html { redirect_to @layout_template, notice: 'Layout template was successfully created.' }
        format.json { render json: @layout_template, status: :created, location: @layout_template }
      else
        format.html { render action: "new" }
        format.json { render json: @layout_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /layout_templates/1
  # PUT /layout_templates/1.json
  def update
    @layout_template = LayoutTemplate.find(params[:id])

    respond_to do |format|
      if @layout_template.update_attributes(params[:layout_template])
        format.html { redirect_to @layout_template, notice: 'Layout template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @layout_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layout_templates/1
  # DELETE /layout_templates/1.json
  def destroy
    @layout_template = LayoutTemplate.find(params[:id])
    @layout_template.destroy

    respond_to do |format|
      format.html { redirect_to layout_templates_url }
      format.json { head :no_content }
    end
  end

  def layout_templates_list
    @total_count = params[:total_count].to_i
    @current_page = params[:page_number].to_i
    @layout_templates = LayoutTemplate.with_translations(I18n.locale).
        offset((params[:page_number].to_i - 1) * LAYOUT_TEMPLATES_PER_PAGE_COUNT).
        limit(LAYOUT_TEMPLATES_PER_PAGE_COUNT)
    respond_to do |format|
      format.js { render :layout_templates_list }
    end
  end
end

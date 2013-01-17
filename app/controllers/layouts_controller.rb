class LayoutsController < ApplicationController
  # GET /layouts
  # GET /layouts.json
  def index
    @layouts = Layout.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @layouts }
    end
  end

  # GET /layouts/1
  # GET /layouts/1.json
  def show
    @layout = Layout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @layout }
    end
  end

  # GET /layouts/new
  # GET /layouts/new.json
  def new
    @layout = Layout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @layout }
    end
  end

  # GET /layouts/1/edit
  def edit
    @layout = Layout.find(params[:id])
  end

  # POST /layouts
  # POST /layouts.json
  def create
    @layout = Layout.new(params[:layout])

    respond_to do |format|
      if @layout.save
        format.html { redirect_to @layout, notice: 'Layout was successfully created.' }
        format.json { render json: @layout, status: :created, location: @layout }
      else
        format.html { render action: "new" }
        format.json { render json: @layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /layouts/1
  # PUT /layouts/1.json
  def update
    @layout = Layout.find(params[:id])

    respond_to do |format|
      if @layout.update_attributes(params[:layout])
        format.html { redirect_to @layout, notice: 'Layout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @layout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layouts/1
  # DELETE /layouts/1.json
  def destroy
    @layout = Layout.find(params[:id])
    @layout.destroy

    respond_to do |format|
      format.html { redirect_to layouts_url }
      format.json { head :no_content }
    end
  end
end

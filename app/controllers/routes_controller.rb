class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.all
  end

  # GET /routes/1
  def show
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  def create
    if params[:secret] != 'e6902c80c51b5ddb2612ada39d3a8b60'
      render nothing: true, status: 401
      return
    end

    @route = Route.new(route_params)

    if @route.save
      render text: "#{root_url}#{@route.key}", status: 200
    else
      render nothing: true, status: 404
    end
  end

  # PATCH/PUT /routes/1
  def update
    if @route.update(route_params)
      redirect_to @route, notice: 'Route was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
    redirect_to routes_url, notice: 'Route was successfully destroyed.'
  end

  def redirect
    @route = Route.where(key: params[:key]).first
    if @route
      redirect_to @route.url, status: 301
    else
      redirect_to 'http://sharecloset.co.kr'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_params
      params.require(:route).permit(:key, :url)
    end
end

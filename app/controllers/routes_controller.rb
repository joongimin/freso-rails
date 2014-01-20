class RoutesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  SECRET = 'e6902c80c51b5ddb2612ada39d3a8b60'

  # GET /routes
  def index
    @routes = Route.order(id: :desc).page(params[:page])
  end

  # POST /routes
  def create
    if params[:secret] != SECRET
      render nothing: true, status: 401
      return
    end

    @route = Route.new(url: params[:url])

    if @route.save
      render text: "#{root_url}#{@route.hash_key}", status: 200
    else
      render nothing: true, status: 404
    end
  end

  def redirect
    @route = Route.where(hash_key: params[:hash_key]).first
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
end

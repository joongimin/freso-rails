class NuvoController < ApplicationController
  def login
  end

  def callback
    if params.include?(:code)
      session['nuvo_access_token'] = params[:code]

      respond_to do |format|
        format.html { render :authorize, :layout => false }
      end
    else
      raise
    end
  end
end
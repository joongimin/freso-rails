class SessionsController < ApplicationController
  skip_before_filter :renew_access_token, :only => :create

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    @referer = params[:referer]
    render :create, :layout => false
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
end
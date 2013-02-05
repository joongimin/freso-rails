class SessionsController < ApplicationController
  skip_before_filter :renew_access_token, :only => :create

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    if env["omniauth.params"].include?("rp")
      redirect_to env["omniauth.params"]["rp"]
    else
      @referer = params[:referer]
      render :create, :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end

  def logged_out
    render :logged_out, :layout => false
  end

  def facebook
    redirect_to "http://dev3.xnuvo.com:3000/ko-KR/facebook/login?rp=%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26client_id%3D5632dc5b2bff993a82050f842fce7f037d933311cade8ee566a656436720fe6c%26redirect_uri%3Dhttp%253A%252F%252Fdl.fre.so%253A2999%252Fauth%252Fnuvo%252Fcallback%26state%3D3807c4de4e430389f5d6bdd1ad012f61b1e8b7f0b50f1b3b"
  end

  def twitter
    redirect_to "http://dev3.xnuvo.com:3000/ko-KR/twitter/login?rp=%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26client_id%3D5632dc5b2bff993a82050f842fce7f037d933311cade8ee566a656436720fe6c%26redirect_uri%3Dhttp%253A%252F%252Fdl.fre.so%253A2999%252Fauth%252Fnuvo%252Fcallback%26state%3D2a6d53a0f811f472e79fde4269a28f1044079375d10a0fbe"
  end
end
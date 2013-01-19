class JavascriptExceptionController < ApplicationController
  class JavascriptException < StandardError
    def initialize(message, url, linenumber)
      super "Javascript error: #{message} on line #{linenumber} for #{url}"
    end
  end

  def create
    raise JavascriptException.new(params[:message], params[:url], params[:linenumber])
  end
end
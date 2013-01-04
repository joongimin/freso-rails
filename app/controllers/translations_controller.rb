class TranslationsController < ApplicationController
private
  def update_or_create
    @translation = Translation.new(params[:translation])
    if @translation.valid?
      @translation.store!
      redirect_to translations_path, :notice => "Updated translation"
    else
      session[:translation] = @translation
      redirect_to translations_path
    end
  end

public
  def index
    if session[:translation]
      @translation = session[:translation]
      session[:translation] = nil
    end

    @translations = ActiveSupport::OrderedHash.new
    @translations[nil] = {}
    TRANSLATION_STORE.keys.sort.each do |key|
      keys = key.split(".")
      if keys.length < 2
        raise "Invalid key #{key}"
      elsif keys.length == 2
        locale = keys[0]
        @translations[nil][keys[1]] ||= {}
        @translations[nil][keys[1]][locale.to_sym] = TRANSLATION_STORE[key]
      elsif keys.length == 3
        locale = keys[0]
        @translations[keys[1]] ||= {}
        @translations[keys[1]][keys[2]] ||= {}
        @translations[keys[1]][keys[2]][locale.to_sym] = TRANSLATION_STORE[key]
      else
        raise "Invalid key #{key}"
      end
    end

    @translations.delete(nil) if @translations[nil].empty?
  end

  def update
    update_or_create
  end

  def create
    update_or_create
  end

  def destroy
    I18n.available_locales.each do |locale|
      TRANSLATION_STORE.del("#{locale}.#{params[:key]}")
    end
    redirect_to translations_path, :notice => "Removed translation"
  end
end
class TranslationsController < ApplicationController
  def index
    @translations = TRANSLATION_STORE
  end

  def create
    I18n.backend.store_translations(params[:locale], {params[:key] => params[:value]}, :escape => false)
    redirect_to translations_path, :notice => "Added translations"
  end

  def destroy
    TRANSLATION_STORE.del("#{params[:locale]}.#{params[:key]}")
    redirect_to translations_path, :notice => "Removed translation"
  end
end

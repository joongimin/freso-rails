class Translation < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  def self.find_with_key(key)
    keys = []
    I18n.available_locales.each do |locale|
      k = TRANSLATION_STORE.keys("#{locale}.#{key}")
      keys << k[0] if !k.empty?
    end

    if keys.empty?
      nil
    else
      params = {:key => key}
      keys.each do |k|
        locale = k.split(".")[0]
        params[:translation_values_attributes] ||= []
        params[:translation_values_attributes] << {:locale => locale.to_sym, :value => ActiveSupport::JSON.decode(TRANSLATION_STORE[k])[0]}
      end
      Translation.new(params)
    end
  end

  column :key
  has_many :translation_values

  accepts_nested_attributes_for :translation_values
  attr_accessible :key, :translation_values, :translation_values_attributes

  validates :key, :presence => true

  def store!
    translation_values.each do |translation_value|
      I18n.backend.store_translations(translation_value.locale, {key => translation_value.value}, :escape => false)
    end
  end
end
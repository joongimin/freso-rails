class TranslationValue < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :locale
  column :value
  column :translation_id

  belongs_to :translation

  validates :locale, :format => {:with => /#{I18n.available_locales.join("|")}/}
  validates :value, :presence => true
  attr_accessible :locale, :value
end
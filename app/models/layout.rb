class Layout < ActiveRecord::Base
  attr_accessible :layout_option, :brand_id, :layout_template_id

  belongs_to :brand
  belongs_to :layout_template

  validates :layout_template_id, :presence => {:message => Proc.new {I18n.t("layouts.validation.layout_template")}}
  validates :brand_id, :presence => true
end
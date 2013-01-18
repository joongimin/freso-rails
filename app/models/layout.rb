class Layout < ActiveRecord::Base
  attr_accessible :layout_option, :brand_id, :layout_template_id

  belongs_to :brand
  belongs_to :layout_template
end
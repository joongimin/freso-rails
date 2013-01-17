class Layout < ActiveRecord::Base
  attr_accessible :layout_option

  belongs_to :brand
  belongs_to :layout_template
end
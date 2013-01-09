class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub_type, :layout_id, :uri
  translates :name
  belongs_to :user
end

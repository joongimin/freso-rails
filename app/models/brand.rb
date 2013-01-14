class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub_type, :layout_id, :uri, :name
  translates :name
  belongs_to :user
end

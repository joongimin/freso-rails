class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub_type, :layout_id, :uri

  belongs_to :user

  validates_uniqueness_of :uri

  translates :name
end

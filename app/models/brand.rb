class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub_type, :layout_id, :uri, :name
  translates :name

  belongs_to :user

  validates :name, :presence => true
  validates :uri, :presence => true, :uniqueness => true, :uri_format => true
  validates :hub_type, :presence => true
end

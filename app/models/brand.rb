class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub_type, :layout_id, :uri, :name, :user_id
  translates :name

  belongs_to :user
  has_many :layouts
  belongs_to :current_layout, :class_name => "Layout"

  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :uri, :presence => true, :uniqueness => true, :uri_format => true, :length => { :minimum => 3, :maximum => 20 }
  validates :hub_type, :presence => true
end
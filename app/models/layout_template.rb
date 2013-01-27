class LayoutTemplate < ActiveRecord::Base
  attr_accessible :layout_option_template, :name, :description, :image, :image_attributes, :main_layout
  translates :name, :description

  belongs_to :user
  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image

  before_create :before_create
  after_initialize :after_initialize

  def before_create
  	self.user = User.admin
  end

  def after_initialize
  	build_image if image.nil?
  end

  def main_layout
    return nil if self.option_value_encoded.nil? || self.option_value_encoded.empty?
    option_value["main_layout"]
  end

  def main_layout=(val)
    l = option_value
    l["main_layout"] = val
    self.option_value_encoded = l.to_json
  end

private
  def option_value
    self.option_value_encoded.blank? ? {} : JSON.parse(self.option_value_encoded)
  end
end
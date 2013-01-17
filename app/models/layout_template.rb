class LayoutTemplate < ActiveRecord::Base
  attr_accessible :layout_option_template, :name, :description, :image, :image_attributes
  translates :name, :description

  belongs_to :user
  has_one :image, :as => :imageable

  accepts_nested_attributes_for :image

  before_create :before_create
  after_initialize :after_initialize

  def before_create
  	#TODO: Remove this when design store is implemented
  	#self.user = User.admin
  end

  def after_initialize
  	build_image if image.nil?
  end
end
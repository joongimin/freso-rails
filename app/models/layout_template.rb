class LayoutTemplate < ActiveRecord::Base
  attr_accessible :layout_option_template, :name, :description, :preview_image
  translates :name, :description

  belongs_to :user

  mount_uploader :preview_image, ImageUploader

  before_create :before_create

  def before_create
  	#TODO: Remove this when design store is implemented
  	#self.user = User.admin
  end
end
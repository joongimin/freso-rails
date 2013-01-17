class Image < ActiveRecord::Base
	attr_accessible :imageable, :image
  belongs_to :imageable, :polymorphic => true
  mount_uploader :image, ImageUploader
  before_save :before_save

  def before_save
    self.environment ||= Rails.env
  end
end

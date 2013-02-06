class LayoutSection < ActiveRecord::Base
  attr_accessible :key, :layout_options_attributes, :mustache
  has_many :layout_options, :dependent => :destroy

  accepts_nested_attributes_for :layout_options
  belongs_to :layout_sectionable, :polymorphic => true

  validates :key, :presence => true
end
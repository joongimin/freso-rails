class Brand < ActiveRecord::Base
  attr_accessible :uid, :hub, :layout_id, :uri, :name, :user_id
  translates :name

  belongs_to :user
  has_many :layouts
  belongs_to :current_layout, :class_name => "Layout"
  belongs_to :temporary_layout, :class_name => "Layout"

  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :uri, :presence => true, :uniqueness => true, :uri_format => true, :length => { :minimum => 3, :maximum => 20 }
  validates :hub, :presence => {:message => Proc.new {I18n.t("brands.validation.hub")}}

  def self.guide_steps
    4
  end

  def current_layout
    result = super

    if result.nil?
      if !layouts.empty?
        result = layouts.last
      else
        result = Layout.new(:brand_id => self.id)
        result.save(:validate => false)
      end
      update_attribute(:current_layout_id, result.id)
    end

    result
  end

  def html(args = {})
    current_layout.html(args)
  end
end
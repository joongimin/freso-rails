class LayoutTemplate < ActiveRecord::Base
  attr_accessible :layout_option_template, :name, :description, :image, :image_attributes, :main_layout, :script, :mustache, :layout_sections_attributes
  translates :name, :description

  belongs_to :user
  has_one :image, :as => :imageable
  has_many :layout_sections, :as => :layout_sectionable, :dependent => :destroy

  accepts_nested_attributes_for :image, :layout_sections

  before_create :before_create
  after_initialize :after_initialize

  def before_create
  	self.user = User.admin
  end

  def after_initialize
  	build_image if image.nil?
    if self.layout_sections.count == 0
      self.mustache = ActionController::Base.new.render_to_string("layout_templates/defaults/main_layout")
      self.layout_sections.new(:key => "main_layout", :layout_options_attributes => [
        {:key => "font_family", :option_type => "css@font-family", :value => "Helvetica Neue"},
        {:key => "font_size", :option_type => "css@font-size", :value => "11px"},
        {:key => "background_color", :option_type => "css@background-color", :value => "#777"},
        ])
      self.layout_sections.new(:key => "script", :mustache => ActionController::Base.new.render_to_string("layout_templates/defaults/script"))
      self.layout_sections.new(:key => "logo", :mustache => ActionController::Base.new.render_to_string("layout_templates/defaults/logo"))
      self.layout_sections.new(:key => "login", :mustache => ActionController::Base.new.render_to_string("layout_templates/defaults/login"), :layout_options_attributes => [
        {:key => "menu_items", :option_type => "array", :value => [{"title" => "login with nuvo"}, {"title" => "view basket"}].to_json},
        {:key => "font_family", :option_type => "css@font-family", :value => "Helvetica Neue"},
        {:key => "font_size", :option_type => "css@font-size", :value => "11px"},
        {:key => "background_color", :option_type => "css@background-color", :value => "#777"},
        ])
    end
  end
end
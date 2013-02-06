class Layout < ActiveRecord::Base
  attr_accessible :layout_option, :brand_id, :layout_template_id, :layout_sections_attributes
  has_many :layout_sections, :as => :layout_sectionable
  has_many :layout_options, :through => :layout_sections
  accepts_nested_attributes_for :layout_sections

  belongs_to :brand
  belongs_to :layout_template

  validates :layout_template_id, :presence => {:message => Proc.new {I18n.t("layouts.validation.layout_template")}}
  validates :brand_id, :presence => true

  def self.clone(layout)
    layout_sections = {}

    layout.layout_template.layout_sections.each do |layout_section|
      layout_sections[layout_section.key] = {}
      layout_section.layout_options.each do |layout_option|
        layout_sections[layout_section.key][layout_option.key] = {
          :option_type => layout_option.option_type,
          :value => layout_option.value
        }
      end
    end

    layout.layout_sections.each do |layout_section|
      next unless layout_sections.include?(layout_section.key)
      layout_section.layout_options.each do |layout_option|
        next unless layout_sections[layout_section.key].include?(layout_option.key)
        layout_sections[layout_section.key][layout_option.key][:value] = layout_option.value
      end
    end

    args = {
      :layout_template_id => layout.layout_template_id,
      :brand_id => layout.brand_id,
      :layout_sections_attributes => {}
      }

    section_index = 0
    layout_sections.each do |section_key, section_value|
      layout_section_attributes = {:key => section_key, :layout_options_attributes => {}}
      option_index = 0
      section_value.each do |option_key, option_value|
        layout_section_attributes[:layout_options_attributes][option_index.to_s] = {:key => option_key, :option_type => option_value[:option_type], :value => option_value[:value]}
        option_index += 1
      end
      args[:layout_sections_attributes][section_index.to_s] = layout_section_attributes
      section_index += 1
    end

    result = self.create(args)
  end

  def html(args = {})
    # Render mustache
    result = Mustache.render(self.mustache, self.html_args)

    # Interpolate option args
    Mustache.render(result, self.options_args)
  end

  def mustache
    result = read_attribute(:mustache) || self.layout_template ? self.layout_template.mustache : ""
  end

  def html_args(args = {})
    result = {}
    if self.layout_template
      self.layout_template.layout_sections.each do |layout_section|
        result[layout_section.key] = layout_section.mustache if !layout_section.mustache.nil?
      end
    end

    self.layout_sections.each do |layout_section|
      next unless result.include?(layout_section.key)
      result[layout_section.key] = layout_section.mustache
    end

    result
  end

  def options_args
    result = {}
    if self.layout_template
      self.layout_template.layout_sections.each do |layout_section|
        layout_section.layout_options.each do |layout_option|
          logger.debug "#{layout_section.key}_#{layout_option.key} #{layout_option.value}"
          result["#{layout_section.key}_#{layout_option.key}"] = layout_option.value
        end
      end
    end

    self.layout_sections.each do |layout_section|
      layout_section.layout_options.each do |layout_option|
        key = "#{layout_section.key}_#{layout_option.key}"
        next unless result.include?(key)
        result[key] = layout_option.value
      end
    end

    result
  end

  def sections
    result = ActiveSupport::OrderedHash.new

    # Initialize values from layout template
    if self.layout_template
      self.layout_template.layout_sections.each do |layout_section|
        result[layout_section.key] = ActiveSupport::OrderedHash.new
        layout_section.layout_options.each do |layout_option|
          result[layout_section.key][layout_option.key] = {:option_type => layout_option.option_type, :value => layout_option.value}
        end
      end
    end

    # Override values using layout configurations
    self.layout_sections.each do |layout_section|
      next unless result.include?(layout_section.key)
      layout_section.layout_options.each do |layout_option|
        next unless result[layout_section.key].include?(layout_option.key)
        result[layout_section.key][layout_option.key][:value] = layout_option.value
      end
    end

    result
  end
end
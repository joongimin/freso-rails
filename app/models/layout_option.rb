class LayoutOption < ActiveRecord::Base
  attr_accessible :key, :option_type, :value
  belongs_to :layout_section

  validates :key, :presence => true
  validates :option_type, :presence => true
  validates :value, :presence => true

  # It seems value is interpreted as array automatically? Is this really the case?
  def value
    if self.option_type == "array"
      JSON.parse(self.read_attribute(:value))
    else
      self.read_attribute(:value)
    end
  end
end
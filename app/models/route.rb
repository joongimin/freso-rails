class Route < ActiveRecord::Base
  before_validation :set_key

  validates :key, presence: true, uniqueness: true
  validates :url, presence: true

  def set_key
    while true
      self.key = SecureRandom.base64.delete('/+=')[0, 6]
      break if Route.where(key: self.key).empty?
    end
  end
end

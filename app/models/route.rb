class Route < ActiveRecord::Base
  SECRET = 'e6902c80c51b5ddb2612ada39d3a8b60'

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

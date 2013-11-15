class Route < ActiveRecord::Base
  SECRET = 'e6902c80c51b5ddb2612ada39d3a8b60'

  before_validation :set_hash_key

  validates :hash_key, presence: true, uniqueness: true
  validates :url, presence: true

  def set_hash_key
    while true
      self.hash_key = SecureRandom.base64.delete('/+=')[0, 6]
      break if Route.where(hash_key: self.hash_key).empty?
    end
  end
end

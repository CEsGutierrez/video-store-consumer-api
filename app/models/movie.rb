class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  
  
  validates :title, :overview, :release_date, :image_url, :inventory, :external_id, presence: true
  
  def available_inventory
    self.inventory - Rental.where(movie: self, returned: false).length
  end
  
  def image_url
    raw_value = read_attribute :image_url
    if !raw_value
      MovieWrapper::DEFAULT_IMG_URL
    elsif /^https?:\/\//.match?(raw_value)
      raw_value
    else
      MovieWrapper.construct_image_url(raw_value)
    end
  end
end

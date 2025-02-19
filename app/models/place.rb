class Place < ApplicationRecord
  has_many :event_places, dependent: :destroy
  has_many :events, through: :event_places
  has_many :posts, as: :postable, dependent: :destroy
  
  validates :name, :address, :description, presence: true 

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }

end

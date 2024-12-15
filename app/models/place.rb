class Place < ApplicationRecord
  has_many :event_places
  has_many :events, through: :event_places

  validates :name, :address, :description, presence: true 
end

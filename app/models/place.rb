class Place < ApplicationRecord
  has_many :event_places
  has_many :events, through: :event_places
  has_many :post, as: :postable, dependent: :destroy
  
  validates :name, :address, :description, presence: true 
end

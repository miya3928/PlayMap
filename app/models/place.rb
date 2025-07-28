class Place < ApplicationRecord
  require 'jp_prefecture'
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  has_one_attached :image
  has_many :event_places, dependent: :destroy
  has_many :events, through: :event_places
  has_many :posts, as: :postable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  validates :name, :prefecture, :city, :street, :description, presence: true 

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def full_address
    "#{prefecture_name} #{city} #{street}"
  end
end

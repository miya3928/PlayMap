class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

 validate :name, pressence: true, uniqueness: true
end

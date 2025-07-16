class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comments, as: :commetable, dependent: :destroy
  has_one_attached :image

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true
end

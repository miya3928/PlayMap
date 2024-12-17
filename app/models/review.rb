class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true
end

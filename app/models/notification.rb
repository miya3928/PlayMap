class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User"
  belongs_to :visited, class_name: "User"
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :comment_like, optional: true
  belongs_to :review, optional: true
  belongs_to :review_like, optional: true

  scope :unchecked, -> { where(checked: false) }
end

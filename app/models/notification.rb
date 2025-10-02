class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User"
  belongs_to :visited, class_name: "User"

  scope :unchecked, -> { where(checked: false) }
end

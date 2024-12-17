class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :user

  scope :for_places, -> { where(postable_type: 'Place')}
  scope :for_events, -> { where(postable_type: 'Event')}

  validates :title, :body, presence: true
end

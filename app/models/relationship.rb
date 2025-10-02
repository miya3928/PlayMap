class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  after_create :create_notification_follow

  private

  def create_notification_follow
    Notification.create!(
      visitor_id: follower_id,
      visited_id: followed_id,
      action: "follow"
    )
  end

end
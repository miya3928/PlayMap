class ReviewLike < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: { scope: :review_id }

  after_create :create_notification

  private

  def create_notification
    return if user_id == review.user_id # 自分の投稿なら通知不要

    Notification.create!(
      visitor_id: user_id,
      visited_id: review.user_id,
      comment_id: review.id,
      action: 'review_like'
    )
  end
end

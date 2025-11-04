class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :user_id, uniqueness: { scope: :comment_id }

  after_create :create_notification

  private

  def create_notification
    return if user_id == comment.user_id # 自分の投稿なら通知不要

    Notification.create!(
      visitor_id: user_id,
      visited_id: comment.user_id,
      comment_id: comment.id,
      action: 'comment_like'
    )
  end
end

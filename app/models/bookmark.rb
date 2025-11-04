class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:bookmarkable_type, :bookmarkable_id] }

  after_create :create_notification

  private

  def create_notification
    # コメントされた対象が投稿なら
    if bookmarkable_type == "Post"
      visited_user_id =    bookmarkable.user_id
    # レビューへのコメントなら
    elsif bookmarkable_type == "Review"
      visited_user_id =  bookmarkable.user_id
    end

    # 自分以外に通知を送る
    return if user_id == visited_user_id

    Notification.create!(
      visitor_id: user_id,
      visited_id: visited_user_id,
      comment_id: id,
      action: 'bookmark'
    )
  end
end

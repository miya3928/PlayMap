class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commetable, polymorphic: true
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :user
  
  after_create :create_notification

  private

  def create_notification
    # コメントされた対象が投稿なら
    if commetable_type == "Post"
      visited_user_id = commetable.user_id
    # レビューへのコメントなら
    elsif commetable_type == "Review"
      visited_user_id = commetable.user_id
    end

    # 自分以外に通知を送る
    return if user_id == visited_user_id

    Notification.create!(
      visitor_id: user_id,
      visited_id: visited_user_id,
      comment_id: id,
      action: 'comment'
    )
  end
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image
  has_many :comments, as: :commetable, dependent: :destroy
  has_many :review_likes, dependent: :destroy
  has_many :liked_users, through: :review_likes, source: :user
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true

  after_create :create_notification

  private

  def create_notification
    return if user_id == post.user_id

    Notification.create!(
      visitor_id: user_id,
      visited_id: post.user_id,
      review_id: id,
      post_id: post.id,
      action: 'review'
    )
  end
end

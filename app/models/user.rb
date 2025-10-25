class User < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :comment
  has_many :review_likes, dependent: :destroy
  has_many :liked_reviews, through: :review_likes, source: :review

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_reviews, through: :bookmarks, source: :bookmarkable, source_type: 'Review'
  has_many :bookmarked_places, through: :bookmarks, source: :bookmarkable, source_type: 'Place'
  has_many :bookmarked_events, through: :bookmarks, source: :bookmarkable, source_type: 'Event'

  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_notifications, class_name: "Notification",foreign_key: "visitor_id",dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",foreign_key: "visited_id",dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6 }, on:create, unless: -> { guest_user? } 

  # フォローしているか判定
  def following?(other_user)
    following.include?(other_user)
  end

  # フォローする
  def follow(other_user)
    following << other_user unless self == other_user || following?(other_user)
  end

  # フォローを外す
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end
  
  def admin?
    admin.present?
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
  
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
  
    result = update(params, *options) 
    clean_up_passwords
    result
  end

GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL )do |user|
     user.password = SecureRandom.urlsafe_base64
     user.name = "ゲストユーザー"
   end
  end

  def guest?
    email == GUEST_USER_EMAIL
  end

end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commetable, polymorphic: true
  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :user

end

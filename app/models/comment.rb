class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commetable, polymorphic: true
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :user

end

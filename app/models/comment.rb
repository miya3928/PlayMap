class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commetable, polymorphic: true
end

class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6 }, on:create ,unless: -> { guest_user? } 

  def guest?
      email == 'guest@example.com' if email.present?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com')do |user|
     user.password = SecureRandom.urlsafe_base64
     user.name = "ゲスト"
   end
  end
end

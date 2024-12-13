class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6 }, on:create, unless: -> { guest_user? } 

  def password_required?
    new_record? || password.present? || password_confirmation.present?
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

class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :comments, as: :commetable, dependent: :destroy

  scope :for_places, -> { where(postable_type: 'Place')}
  scope :for_events, -> { where(postable_type: 'Event')}

  validates :title, :body, presence: true

  # 投稿タイプを判別
  def postable_type_display
    case postable_type
    when "Place"
      "場所"
    when "Event"
      "イベント"
    else
      "その他"
    end
  end

  def postable_details
    case postable_type
    when "Place"
      "場所名: #{postable.name}" if postable.respond_to?(:name)
      "住所: #{postable.address}" if postable.respond_to?(:address)
    when "Event"
      "イベント名: #{postable.title}" if postable.respond_to?(:title)
      "開始日時: #{postable.start_date.strftime('%Y年%m月%d日')}" if postable.respond_to?(:start_date)
    else
      "関連情報なし"
    end
  rescue StandardError => e
    "情報取得エラー: #{e.message}"
  end
  
  scope :search_by_keyword, ->(keyword) {
    where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
  }
end

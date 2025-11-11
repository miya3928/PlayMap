    class Bookmark < ApplicationRecord
      belongs_to :user
      belongs_to :bookmarkable, polymorphic: true
    
      validates :user_id, uniqueness: { scope: [:bookmarkable_type, :bookmarkable_id] }
    
      after_create :create_notification
    
      private
    
      def create_notification
        visited_user_id = nil
        notifiable_id = nil
        notifiable_id_field = nil # post_id, review_id のいずれかを格納
    
        # ブックマークされた対象が投稿 (Post) の場合
        if bookmarkable_type == "Post"
          visited_user_id = bookmarkable.user_id
          notifiable_id_field = :post_id
          notifiable_id = bookmarkable.id
    
        # ブックマークされた対象がレビュー (Review) の場合
        elsif bookmarkable_type == "Review"
          visited_user_id = bookmarkable.user_id
          notifiable_id_field = :review_id
          notifiable_id = bookmarkable.id
        end
    
        # visited_user_id が設定されていない (Post/Review以外) または自分自身の場合は通知をスキップ
        return if visited_user_id.nil? || user_id == visited_user_id
    
        # 通知レコードの属性を動的に構築
        notification_attributes = {
          visitor_id: user_id,
          visited_id: visited_user_id,
          action: 'bookmark'
        }
    
        # 適切なIDフィールドに値を設定
        if notifiable_id_field.present?
          notification_attributes[notifiable_id_field] = notifiable_id
        end
    
        Notification.create!(notification_attributes)
      end
    end
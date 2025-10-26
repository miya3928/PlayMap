class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notifications

  def index
    @notifications = current_user.passive_notifications.order(created_at: :desc)
    @notifications.where(checked: false).update_all(checked: true)
  end

  def update_all
    current_user.passive_notifications.update_all(checked: true)
    redirect_to notifications_path, notice: "すべて既読にしました"
  end
end

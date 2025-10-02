class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.order(created_at: :desc)
  end

  def update_all
    current_user.passive_notifications.update_all(checked: true)
    redirect_to notifications_path, notice: "すべて既読にしました"
  end
end

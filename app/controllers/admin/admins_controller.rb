class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  private

  def check_admin
    unless current_user&.admin?
      flash[:alert] = "管理者権限が必要です。"
      redirect_to root_path
    end
  end
end

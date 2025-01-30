class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :deactivate, :reactivate]

  def index
    @users = User.all
  end

  def show
  end

  def deactivate
    if @user.update(is_active: false)
      redirect_to admin_users_path, notice: "ユーザーを退会させました"
    else
      render :show, alert: "退会処理に失敗しました"
    end
  end

  def reactivate
    if @user.update(is_active: true)
      redirect_to admin_users_path, notice: "ユーザーを復帰させました"
    else
      render :show, alert: "復帰処理に失敗しました"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
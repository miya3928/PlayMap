class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(is_active: false)
      redirct_to admin_users_path, notice: "ユーザーを退会させました"
    else
      render :show, alert: "退会処理に失敗しました"
    end     
  end
end

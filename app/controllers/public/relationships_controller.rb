class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to request.referer || root_path
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to request.referer || root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
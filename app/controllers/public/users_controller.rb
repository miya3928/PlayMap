class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:mypage, :edit, :update, :destroy]

  def mypage
    @user = current_user
    @posts = current_user.posts
    @reviews = current_user.reviews
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(9)
    @relationship_type = :followers
    render :relationships
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(9)
    @relationship_type = :following
    render :relationships
  end 

  def index
    @users = User.where.not(email: User::GUEST_USER_EMAIL)
    @users = @users.where.not(id: current_user.id) if user_signed_in?
    @users = @users.page(params[:page]).per(9)
  end

  def edit
    @user = current_user
  end

  def destroy
    current_user.update(is_active: false)  
    sign_out current_user
    flash.now[:alert] = '退会しました'
    redirect_to new_user_registration_path
  end

  def show
    if current_user == User.find(params[:id])
      redirect_to mypage_path and return
    end
  
    @user = User.find(params[:id])
    @posts = @user.posts
    @reviews = @user.reviews
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:alert] = 'ユーザー情報が更新されました'
      redirect_to mypage_path
    else
      render :edit
    end
  end

  private

  def correct_user
    user = User.find(params[:id])
    unless current_user == user
      redirect_to mypage_path, alert: "他のユーザー情報を編集することはできません"
    end
  end    

  def ensure_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはプロフィールにアクセスできません。'
    end
  end 

 def user_params
   params.require(:user).permit(:name, :image, :introduction, :email)
 end
 
end

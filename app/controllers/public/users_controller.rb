class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = current_user.posts
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
    @user = User.find(params[:id])
    @posts = @user.posts
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

  def search
    if params[:search_query]
      @users = User.where('name LIKE ?', "%#{params[:search_query]}%")
    else
      @users = User.none  
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
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end 

 def user_params
   params.require(:user).permit(:name, :introduction, :email)
 end
 
end

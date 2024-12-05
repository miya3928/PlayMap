class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
  end

def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "退会しました"
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_path, notice: "ユーザー情報が更新されました"
    else
      render :edit
    end
  end

  

  private

 def user_params
   params.require(:user).permit(:name, :introduction, :email)
 end

end

class Public::RegistrationsController < Devise::RegistrationsController
  protected


  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # 編集後のリダイレクト先を指定するメソッド
  def after_update_path_for(resource)
    mypage_path
  end

  private

  def account_update_params
    params.require(:user).permit(:name, :introduction, :email, :password, :password_confirmation, :current_password)
  end
end
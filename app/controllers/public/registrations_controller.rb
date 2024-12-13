class Public::RegistrationsController < Devise::RegistrationsController
  protected

  # current_password を確認せずにパスワード変更を許可する
  def update_resource(resource, params)
    # パスワードが空白の場合、password と password_confirmation を削除
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    # current_password を削除しないように
    # current_password が空でない場合のみ削除
    if params[:current_password].blank? && !params[:password].present?
      params.delete(:current_password)
    end

    super
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
class ApplicationController < ActionController::Base
  # その他のコード

  # Deviseのエラーメッセージをフラッシュメッセージに変換
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_status

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    mypage_path # ログイン後にリダイレクトするパスを指定
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # ログアウト後にリダイレクトするパスを指定
  end

  def after_sign_up_path_for(resource)
    mypage_path # サインアップ後にリダイレクトするパスを指定
  end

  private

  def check_user_status
    if current_user && !current_user.is_active
      sign_out current_user
      redirect_to new_user_registration_path, alert: "このアカウントは退会済みです。"
    end
  end    
end


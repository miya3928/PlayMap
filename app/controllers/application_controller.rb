class ApplicationController < ActionController::Base
  # その他のコード

  # Deviseのエラーメッセージをフラッシュメッセージに変換
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def after_sign_in_path_for(resource)
    your_path # ログイン後にリダイレクトするパスを指定
  end

  def after_sign_out_path_for(resource_or_scope)
    your_path # ログアウト後にリダイレクトするパスを指定
  end

  def after_sign_up_path_for(resource)
    your_path # サインアップ後にリダイレクトするパスを指定
  end
end


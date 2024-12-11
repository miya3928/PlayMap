class ApplicationController < ActionController::Base
  # ゲストユーザーに関するチェックを新規登録ページ（:new, :create）のみに限定
  before_action :check_guest_user, only: [:new, :create], if: :user_signed_in?

  # Deviseのエラーメッセージをフラッシュメッセージに変換
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_status, unless: :guest_user?

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

  # ゲストユーザーが新規登録ページにアクセスしようとする場合の制限
  def check_guest_user
    if current_user.guest?
      redirect_to posts_path, alert: "ゲストユーザーは新規登録を行うことができません。"
    end
  end

  # ユーザーがゲストユーザーでない場合のみ退会チェック
  def check_user_status
    if current_user && !current_user.is_active
      sign_out current_user
      redirect_to new_user_registration_path, alert: "このアカウントは退会済みです。"
    end
  end

  # ゲストユーザーかどうかを判定するメソッド
  def guest_user?
    current_user&.guest?
  end
end
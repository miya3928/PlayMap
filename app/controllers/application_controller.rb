class ApplicationController < ActionController::Base
  before_action :check_guest_user, only: [:new, :create], if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_user_status, unless: :guest_user?
  before_action :set_notifications, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path # 管理者用ダッシュボードページ
    else
      mypage_path # 一般ユーザー用マイページ
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path # 管理者用ログインページ
    else
      root_path # 一般ユーザー用トップページ
    end
  end

  def after_sign_up_path_for(resource)
    mypage_path # 一般ユーザー用マイページ
  end

  private

  def check_guest_user
    if current_user.guest?
      redirect_to posts_path, alert: "ゲストユーザーは新規登録を行うことができません。"
    end
  end

  def check_user_status
    if current_user && !current_user.is_active
      sign_out current_user
      redirect_to new_user_registration_path, alert: "このアカウントは退会済みです。"
    end
  end

  def guest_user?
    current_user&.guest?
  end

  def set_notifications
    @unchecked_notifications = current_user.passive_notifications.unchecked
  end
end
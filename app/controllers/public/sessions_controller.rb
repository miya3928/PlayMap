class Public::SessionsController < Devise::SessionsController
  def create
    if params[:guest]
      guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.hex(10)
        user.name = 'ゲストユーザー'
        # 必要に応じて以下を追加
        # user.confirmed_at = Time.current # メール認証を有効にしている場合
      end

      sign_in(guest_user)
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    else
      super
    end
  end
end
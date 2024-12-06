Rails.application.routes.draw do
  # user用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    get '/users/sign_in' => 'devise/sessions#new'
  end

  scope module: :public do
    root to: "homes#top"
    get "/about", to: "homes#about", as: 'about'
    get "/mypage", to: "users#mypage", as: 'mypage'
    resources :users, only: [:create, :show, :edit, :update, :destroy]
    resources :posts
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
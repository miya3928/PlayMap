Rails.application.routes.draw do
  namespace :public do
    get 'comments/create'
  end
  # user用
  # URL /users/sign_in ...
   get '/guest_login', to: 'public/sessions#guest_login', as: 'guest_login'

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
    get '/users/sign_in' => 'devise/sessions#new'
  end

  scope module: :public do
    root to: "homes#top"
    get "/about", to: "homes#about", as: 'about'
    get '/mypage', to: 'users#mypage', as: 'mypage'
    resources :users, only: [:create, :show, :edit, :update, :destroy]
    resources :places do
      resources :posts,only: [:new, :create]
    end  

    resources :events do
      resources :posts, only: [:new, :create]
    end  

    resources :posts do
      resources :reviews
    end

    resources :posts do
      resources :comments, only: [:create, :destroy]
    end

    resources :reviews do
      resources :comments, only: [:create, :destroy]
    end
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
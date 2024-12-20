Rails.application.routes.draw do
  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/update'
  end
  namespace :admin do
    get 'dashboard/index'
  end
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
      resources :comments, only: [:create, :destroy]
      collection do
        get :search # searchアクションを追加
      end
    end

    resources :reviews do
      resources :comments, only: [:create, :destroy]
    end
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do 
    root to: "dashboard#index"
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :reviews, only: [:index, :show, :destroy] 
  end  
end
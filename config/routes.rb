Rails.application.routes.draw do

  namespace :public do
    get 'tags/show'
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
    get '/search', to: 'searches#search', as: 'search'
    resources :users, only: [:create, :show, :edit, :update, :destroy]
    resources :tags, only: [:index, :show] do
      collection do
        get 'search', to: 'tags#search'
      end
    end  
    resources :places do
      resources :posts,only: [:new, :create]
    end  

    resources :events do
      resources :posts, only: [:new, :create]
    end  

    resources :posts do
      resources :reviews
      resources :comments, only: [:create, :destroy]
    end

    resources :reviews do
      resources :comments, only: [:create, :destroy]
    end
  end

  # 管理者用
  devise_for :admin,path: 'admin', skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do 
    root to: "dashboard#index"
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :reviews, only: [:index, :show, :destroy] 
    resources :tags, only: [:index,:create, :show, :destroy]
  end  
end
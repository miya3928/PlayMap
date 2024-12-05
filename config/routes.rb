Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
    devise_scope :user do
       get '/users/sign_in' => 'devise/sessions#new'
       get '/users/sign_out' => 'devise/sessions#destroy'
    end

  scope module: :public do
    root to: "homes#top"
    get "/about", to: "homes#about"
    get "/mypage", to: "users#mypage"
    resources :users, only: [:create, :show, :edit, :update]
    resources :posts
  end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end
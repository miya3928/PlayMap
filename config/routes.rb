Rails.application.routes.draw do

  devise_for :users
  # For deta"ils on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  
  scope module: :public do
     root to:"homes#top"
  get "/about", to:"homes#about"
  get "/mypage", to:"users#mypage"
  resources :users, only:[:create,:show,:edit,:update]
  resources :posts
  end
end

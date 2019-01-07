Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#top"
  get "users/login_form"
  post "users/login"
  post "users/logout"
  get "users/:id/password_edit" => "users#password_edit", as: "users_password_edit"
  patch "users/:id/password_update" => "users#password_update", as: "users_password"
  get "users/:id/likes" => "users#like_index", as: "users_likes_index"
  resources :users do
  	resources :like_users, only:[:create, :destroy]
  end
  resources :sounds do
  	resources :comments, only:[:create, :destroy]
    resources :like_sounds, only:[:create, :destroy]
  end
end

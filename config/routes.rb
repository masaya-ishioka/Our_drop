Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#top"
  get "users/login_form"
  post "users/login"
  post "users/logout"
  get "users/:id/password_edit" => "users#password_edit", as: "users_password_edit"
  resources :users do
  	resources :like_sounds, only:[:create, :destroy]
  	resources :like_users, only:[:create, :destroy]
  end
  resources :sounds do
  	resources :comments, only:[:edit, :update, :create, :destroy]
  end
end

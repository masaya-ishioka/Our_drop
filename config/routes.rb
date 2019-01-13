Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#top"
  get "users/login_form"
  post "users/login"
  post "users/logout"
  get "users/:id/active" => "users#active", as: "users_active"
  patch "users/:id/active_update" => "users#active_update", as: "users_active_update"

  get "users/:id/password_edit" => "users#password_edit", as: "users_password_edit"
  patch "users/:id/password_update" => "users#password_update", as: "users_password"

  get "users/password_forget" => "users#password_forget", as: "users_password_forget"
  post "users/email_where" => "users#email_where", as: "users_email_where"
  get "users/:id/password_forget_edit" => "users#password_forget_edit", as: "users_password_forget_edit"
  patch "users/:id/password_forget_update" => "users#password_forget_update", as: "users_password_forget_update"

  get "users/:id/likes" => "users#like_index", as: "users_likes_index"
  get "sounds/day_rank"
  get "sounds/week_rank"
  get "sounds/month_rank"
  resources :users do
  	resources :like_users, only:[:create, :destroy]
  end
  resources :sounds do
  	resources :comments, only:[:create, :destroy]
    resources :like_sounds, only:[:create, :destroy]
  end
end

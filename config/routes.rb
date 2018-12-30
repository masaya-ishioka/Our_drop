Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sounds, only:[:show, :edit, :update, :new,:create, :destroy]

  root "sounds#index"
end

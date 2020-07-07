Rails.application.routes.draw do
  devise_for :users, path_prefix: 'd'

  root 'users#index'

  resources :users
end

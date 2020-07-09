Rails.application.routes.draw do
  devise_for :users, path_prefix: 'd'

  root 'users#index'

  resources :users
  resources :tests, except: [:show]

  namespace :api, format: 'json' do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: '/auth'

      resources :tests, only: [:index, :show]
    end
  end
end

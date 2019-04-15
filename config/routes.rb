require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: '/sidekiq'

  concern :error_prone do
    resources :errors, only: [:index]
    resources :notifications, only: [:index]
  end

  resources :analyses, only: [:show]
  resources :input_files, only: [:create]

  root 'analyses#show'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :analyses, shallow: true, only: [:new, :create, :show] do
    resource :timeframe, only: [:create, :show, :update]
    resource :input_file, only: [:create]
  end
  resources :input_files, only: [:create] do
    resource :scanner, only: [:create, :show]
    resources :access_data, only: [:index]
  end
  root 'analyses#show'
end

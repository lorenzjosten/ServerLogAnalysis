Rails.application.routes.draw do
  resources :timeframes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :input_file, shallow: true do
    resources :access_data
  end

  put 'set_timeframe', to: 'analysis#set_timeframe'

  get 'analysis/index'
  root 'analysis#index'
end

Rails.application.routes.draw do

  get 'analysis/index'

  resource :input_file, shallow: true do
    resources :access_data
  end

  match 'analysis#set_timeframe', to: 'analysis#set_timeframe', via: [:put]

  root 'analysis#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

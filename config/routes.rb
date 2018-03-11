Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :analysis
  resource :timeframe
  resource :input_file, shallow: true do
    resources :access_data
  end

  get 'analyses/index'
  root 'analyses#index'
end

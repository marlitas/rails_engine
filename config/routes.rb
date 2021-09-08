Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find'
      get '/revenue/merchants/:id', to: 'merchants#revenue'
      get '/revenue/weekly', to: 'revenue#week'
      get '/revenue', to: 'revenue#date_range'
      resources :merchants, only: [:index, :show] do
        get '/items', to: 'items#index'
      end
      resources :items, only: [:index, :show] do
        get '/merchant', to: 'merchants#show'
      end
    end
  end
end

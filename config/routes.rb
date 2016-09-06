Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      get '/items/find', to: "items/search#show"
      get '/items/find_all', to: "items/search#index"
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      resources :items, only: [:index]
      resources :invoices, only: [:index]
      resources :invoice_items, only: [:index]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end

end

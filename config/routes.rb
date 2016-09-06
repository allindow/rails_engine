Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      get '/items/find', to: "items/search#show"
      get '/items/find_all', to: "items/search#index"
      get '/invoices/find', to: "invoices/search#show"
      get '/invoices/find_all', to: "invoices/search#index"
      get '/invoice_items/find', to: "invoice_items/search#show"
      get '/invoice_items/find_all', to: "invoice_items/search#index"

      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end

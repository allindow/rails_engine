Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :items, only: [:index, :show] do
        get 'find', on: :collection, to: "items/search#show"
        get 'find_all', on: :collection, to: "items/search#index"
        get 'random', on: :collection, to: "items/random#show"
      end

      resources :invoices, only: [:index, :show] do
        get 'find', on: :collection, to: "invoices/search#show"
        get 'find_all', on: :collection, to: "invoices/search#index"
        get 'random', on: :collection, to: "invoices/random#show"
      end

      resources :invoice_items, only: [:index, :show] do
        get 'find', on: :collection, to: "invoice_items/search#show"
        get 'find_all', on: :collection, to: "invoice_items/search#index"
        get 'random', on: :collection, to: "invoice_items/random#show"
      end

      resources :merchants, only: [:index, :show] do
        get 'find', on: :collection, to: "merchants/search#show"
        get 'find_all', on: :collection, to: "merchants/search#index"
        get 'random', on: :collection, to: "merchants/random#show"
        get 'most_revenue', on: :collection, to: "merchants/most_revenue#index"
        get 'customers_with_pending_invoices', on: :member, to: "merchants/pending_customers#index"

      end

      resources :customers, only: [:index, :show] do
        get 'find', on: :collection, to: "customers/search#show"
        get 'find_all', on: :collection, to: "customers/search#index"
        get 'random', on: :collection, to: "customers/random#show"
      end

      resources :transactions, only: [:index, :show] do
        get 'find', on: :collection, to: "transactions/search#show"
        get 'find_all', on: :collection, to: "transactions/search#index"
        get 'random', on: :collection, to: "transactions/random#show"
      end
    end
  end
end

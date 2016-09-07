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
        get 'transactions', to: 'invoices/transactions#index'
        get 'invoice_items', to: 'invoices/invoice_items#index'
        get 'items', to: 'invoices/items#index'
        get 'customer', to: 'invoices/customers#show'
        get 'merchant', to: 'invoices/merchants#show'
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

      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end

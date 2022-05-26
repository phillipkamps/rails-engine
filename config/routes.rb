Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "merchants/find_all", to: "merchants#find_all"
      get "merchants/most_items", to: "merchants#most_items"

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      resources :items do
        resources :merchant, only: [:index], controller: :item_merchants
      end

      namespace :revenue do
        resources :merchants, only: [:index]
      end
    end
  end
end

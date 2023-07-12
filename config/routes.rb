Rails.application.routes.draw do
  resources :recipe_foods, only: [:create, :update, :destroy]
  resources :inventory_foods, only: [:create, :update, :destroy]
  resources :foods, only: [:create, :update, :destroy]
  resources :inventories, only: [:index, :show, :create, :update, :destroy]
  resources :recipes, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:index]
  resources :shopping_list, only: [:index]

  root to: "users#index", as: "public_recipes"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

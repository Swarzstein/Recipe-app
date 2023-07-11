Rails.application.routes.draw do
  resources :recipe_foods
  resources :inventory_foods
  resources :foods
  resources :inventories
  resources :recipes
  resources :users

  root to: "recipes#index", as: "public_recipes"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

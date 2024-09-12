Rails.application.routes.draw do
  resources :post_images, only: [:new, :index, :show]
  resources :users, only: [:show, :edit]
  devise_for :users
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

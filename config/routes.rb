Rails.application.routes.draw do
  
  
  get 'home/about', to: 'homes#about', as: 'about'
  devise_for :users
  root to: "homes#top"
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:create, :index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

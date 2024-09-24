Rails.application.routes.draw do
  
  
  get 'relationships/create'
  get 'relationships/destroy'
  get 'create/destroy'
  get 'home/about', to: 'homes#about', as: 'about'
  devise_for :users
  root to: "homes#top"
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:create, :index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    	get "followings" => "relationships#followings", as: "followings"
    	get "followers" => "relationships#followers", as: "followers"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

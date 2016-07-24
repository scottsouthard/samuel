Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts

  get 'sessions/new' => "sessions#new"
  post 'sessions/create' => "sessions#create"
  get 'sessions/logout' => "sessions#logout"

end
